# encoding: utf-8

##
# Backup v4.x Configuration
#
# Documentation: http://backup.github.io/backup
# Issue Tracker: https://github.com/backup/backup/issues

Backup::Model.new(:hyku, 'Backup the database and files for Hyku') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  database MySQL do |db|
    db.username           = ENV['MYSQL_USERNAME']
    db.password           = ENV['MYSQL_PASSWORD']
    db.host               = ENV['MYSQL_HOSTNAME']
    db.port               = ENV['MYSQL_PORT']
  end

  # archive :shared do |archive|
  #   archive.add "/media/ephemeral0/uploads"
  #   archive.tar_options '--warning=no-file-changed'
  # end

  compress_with Gzip

  #$ openssl aes-256-cbc -d -base64 -in my_backup.tar.enc -out my_backup.tar
  encrypt_with OpenSSL do |encryption|
    encryption.password = ENV['MYSQL_PASSWORD']
    encryption.base64   = true
    encryption.salt     = true
  end

  Storage::S3.defaults do |s3|
    s3.region             = ENV['AWS_REGION']
    s3.bucket             = ENV['BACKUP_BUCKET']
    s3.path               = ''
    s3.encryption         = :aes256
    s3.storage_class      = :standard
    s3.access_key_id      = ENV['AWS_ACCESS_KEY_ID']
    s3.secret_access_key  = ENV['AWS_SECRET_ACCESS_KEY']
  end

  # Grandfather - Father - Sons implementation
  time = Time.now

  if time.day == 1  # first day of the month
    storage_id = :monthly
    keep = 12000  # only good until the year 3014
    store_with S3, storage_id do |s3|
      s3.keep               = keep
    end
  end

  if time.sunday?
    storage_id = :weekly
    keep = 8
    store_with S3, storage_id do |s3|
      s3.keep               = keep
    end
  end

  storage_id = :daily
  keep = 14

  store_with S3, storage_id do |s3|
    s3.keep               = keep
  end


 sync_with Cloud::S3 do |s3|
   s3.region             = ENV['AWS_REGION']
   s3.bucket             = ENV['BACKUP_BUCKET']
   s3.path               = ''
   s3.encryption         = :aes256
   s3.storage_class      = :standard
   s3.access_key_id      = ENV['AWS_ACCESS_KEY_ID']
   s3.secret_access_key  = ENV['AWS_SECRET_ACCESS_KEY']

   s3.path              = "/shared"
   s3.mirror            = true
   s3.thread_count      = 10

   s3.directories do |directory|
     directory.add "/opt/doris-hyku/shared"

     # Exclude files/folders.
     # The pattern may be a shell glob pattern (see `File.fnmatch`) or a Regexp.
     # All patterns will be applied when traversing each added directory.
     directory.exclude '**/*~'
     directory.exclude /\/tmp$/
   end
 end

 notify_by Mail do |mail|
   mail.on_success           = true
   mail.on_warning           = true
   mail.on_failure           = true

   mail.from                 = ENV['SETTINGS__CONTACT_EMAIL']
   mail.to                   = 'support@notch8.com' # Hipchat or dev team?
   mail.address              = ENV['SMTP_ADDRESS']
   mail.port                 = ENV['SMTP_PORT']
   mail.user_name            = ENV['SMTP_USERNAME']
   mail.password             = ENV['SMTP_PASSWORD']
   mail.authentication       = 'plain'
   mail.encryption           = :starttls
 end
end
