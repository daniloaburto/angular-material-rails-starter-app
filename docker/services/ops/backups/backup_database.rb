##
# Backup Generated: backup_database
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t backup_database [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://meskyanichi.github.io/backup
#
Model.new(:backup_database, 'Application database (PostgreSQL)') do

  ##
  # MongoDB [Database]
  #
  # database MongoDB do |db|
  #   db.name               = "my_database_name"
  #   db.username           = "my_username"
  #   db.password           = "my_password"
  #   db.host               = "localhost"
  #   db.port               = 5432
  #   db.ipv6               = false
  #   db.only_collections   = ["only", "these", "collections"]
  #   db.additional_options = []
  #   db.lock               = false
  #   db.oplog              = false
  # end

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = ENV['POSTGRES_DB_NAME']
    db.username           = ENV['POSTGRES_USER']
    db.password           = ENV['POSTGRES_PASSWORD']
    db.host               = "database"
    db.port               = 5432
    # db.socket             = "/tmp/pg.sock"

    # When dumping all databases, `skip_tables` and `only_tables` are ignored.
    # db.skip_tables        = ["skip", "these", "tables"]
    # db.only_tables        = ["only", "these", "tables"]

    # db.additional_options = ["-xc", "-E=utf8"]
    db.additional_options = ["--compress=6", "--no-owner", "--create", "--clean"]
  end

  ##
  # Amazon Simple Storage Service [Storage]
  #
  # store_with S3 do |s3|
  #   # AWS Credentials
  #   s3.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
  #   s3.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  #
  #   # Or, to use a IAM Profile:
  #   # s3.use_iam_profile = true
  #
  #   s3.region            = ENV['AWS_S3_REGION']
  #   s3.bucket            = ENV['AWS_S3_BUCKET_NAME']
  #   s3.path              = ENV['AWS_S3_BACKUPS_PATH']
  # end

  ##
  # Local (Copy) [Storage]
  #
  store_with Local do |local|
    local.path       = "~/backups/"
    local.keep       = 5
  end

  ##
  # Amazon S3 [Syncer]
  #
  # sync_with Cloud::S3 do |s3|
  #   # AWS Credentials
  #   s3.access_key_id     = "my_access_key_id"
  #   s3.secret_access_key = "my_secret_access_key"
  #   # Or, to use a IAM Profile:
  #   # s3.use_iam_profile = true
  #
  #   s3.bucket            = "my-bucket"
  #   s3.region            = "us-east-1"
  #   s3.path              = "/backups"
  #   s3.mirror            = true
  #   s3.thread_count      = 10
  #
  #   s3.directories do |directory|
  #     directory.add "/path/to/directory/to/sync"
  #     directory.add "/path/to/other/directory/to/sync"
  #
  #     # Exclude files/folders from the sync.
  #     # The pattern may be a shell glob pattern (see `File.fnmatch`) or a Regexp.
  #     # All patterns will be applied when traversing each added directory.
  #     directory.exclude '**/*~'
  #     directory.exclude /\/tmp$/
  #   end
  # end

  ##
  # GPG [Encryptor]
  #
  # Setting up #keys, as well as #gpg_homedir and #gpg_config,
  # would be best set in config.rb using Encryptor::GPG.defaults
  #
  # encrypt_with GPG do |encryption|
  #   # Setup public keys for #recipients
  #   encryption.keys = {}
  #   encryption.keys['user@domain.com'] = <<-KEY
  #     -----BEGIN PGP PUBLIC KEY BLOCK-----
  #     Version: GnuPG v1.4.11 (Darwin)
  #
  #         <Your GPG Public Key Here>
  #     -----END PGP PUBLIC KEY BLOCK-----
  #   KEY
  #
  #   # Specify mode (:asymmetric, :symmetric or :both)
  #   encryption.mode = :both # defaults to :asymmetric
  #
  #   # Specify recipients from #keys (for :asymmetric encryption)
  #   encryption.recipients = ['user@domain.com']
  #
  #   # Specify passphrase or passphrase_file (for :symmetric encryption)
  #   encryption.passphrase = 'a secret'
  #   # encryption.passphrase_file = '~/backup_passphrase'
  # end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  # to customize settings
  compress_with Gzip do |compression|
    compression.level = 6
    # compression.rsyncable = true
  end

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the documentation for other delivery options.
  #
  # notify_by Mail do |mail|
    # mail.on_success           = true
    # mail.on_warning           = true
    # mail.on_failure           = true

    # mail.from                 = "sender@email.com"
    # mail.to                   = "receiver@email.com"
    # mail.address              = "smtp.gmail.com"
    # mail.port                 = 587
    # mail.domain               = "your.host.name"
    # mail.user_name            = "sender@email.com"
    # mail.password             = "my_password"
    # mail.authentication       = "plain"
    # mail.encryption           = :starttls
    #
    # mail.from                 = ENV['BACKUP_NOTIFIER_FROM']
    # mail.to                   = ENV['BACKUP_NOTIFIER_TO']
    # mail.address              = ENV['BACKUP_NOTIFIER_ADDRESS']
    # mail.port                 = ENV['BACKUP_NOTIFIER_PORT']
    # mail.domain               = ENV['BACKUP_NOTIFIER_DOMAIN']
    # mail.user_name            = ENV['BACKUP_NOTIFIER_USER']
    # mail.password             = ENV['BACKUP_NOTIFIER_PASSWORD']
    # mail.authentication       = ENV['BACKUP_NOTIFIER_AUTHENTICATION']
    # mail.encryption           = ENV['BACKUP_NOTIFIER_MAIL_ENCRYPTION']

  # end

end
