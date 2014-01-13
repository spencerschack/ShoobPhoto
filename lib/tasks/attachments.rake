namespace :attachments do
  task :migrate_to_s3 => :environment do
    require 'aws/s3'
    
    # Load credentials
    bucket = ENV['S3_BUCKET_NAME']
    
    # Establish S3 connection
    AWS::S3::Base.establish_connection!(
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    )

    puts AWS::S3::DEFAULT_HOST
    AWS::S3::DEFAULT_HOST.replace 's3-us-west-1.amazonaws.com'

    [Option, ProofImage].each do |klass|

      puts "Class: #{klass.name}"

      defs = klass.attachment_definitions

      defs.keys.each do |attachment|

        puts "Attachment: #{attachment}"
    
        styles = (defs[attachment][:styles].try(:keys) || []) << :original
        
        # Process each attachment
        klass.all.each_with_index do |record, n|
          styles.each do |style|
            next unless record.send("#{attachment}?")
            path = record.send(attachment).url(style)
            file = record.send(attachment).to_file(style)
            
            begin
              AWS::S3::S3Object.store(path, file, bucket, :access => :public_read)
              
            rescue AWS::S3::NoSuchBucket => e
              AWS::S3::Bucket.create(bucket)
              retry
            rescue AWS::S3::ResponseError => e
              raise
            end
            
            puts "Saved #{path} to S3 (#{n}/#{klass.count})"
          end
        end

      end

    end


  end
end