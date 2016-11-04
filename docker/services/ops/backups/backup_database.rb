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

  unless ENV['SLACK_WEBHOOK_URL'].to_s.empty?
    notify_by Slack do |slack|
      slack.on_success = false
      slack.on_warning = true
      slack.on_failure = true

      # The integration token
      slack.webhook_url = ENV['SLACK_WEBHOOK_URL']

      ##
      # Optional
      #
      # The channel to which messages will be sent
      slack.channel = ENV['SLACK_CHANNEL']
      #
      # The username to display along with the notification
      # slack.username = 'my_username'
      #
      # The emoji icon to use for notifications.
      # See http://www.emoji-cheat-sheet.com for a list of icons.
      # slack.icon_emoji = ':ghost:'
      #
      # Change default notifier message.
      # See https://github.com/backup/backup/pull/698 for more information.
      # slack.message = lambda do |model, data|
      #   "[#{data[:status][:message]}] #{model.label} (#{model.trigger})"
      # end
    end
  end

end
