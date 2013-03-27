# Capriza::Aws

Capriza::Aws is a helper gem for AWS tasks. Currently there is one class Capriza::Aws::S3File which can upload, download, add metadata and compare local and S3 files.

## Installation

Add this line to your application's Gemfile:

    gem 'capriza-aws'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capriza-aws

## Usage

To use first create a config.yaml file with the following content

    access_key_id: YOUR_ACCESS_KEY_ID
    secret_access_key: YOUR_SECRET_ACCESS_KEY
    s3_endpoint: YOUR_S3_ENDPOINT

Once configured run the following to instantiate:

    $ require 'capriza-aws'

    $ s3 = Capriza::Aws::S3File('BUCKET_NAME','S3_FILE_NAME','CONFIG_FILE_NAME_FULL_PATH')

To Upload:

    $ s3.upload('Hello World')

or

    $ s3.upload(File.read('FILE_NAME'))

To Download:

    $ data = s3.download
or
    $ File.write('FILE_NAME', s3.download)

To Upload file metadata to S3

    $ s3.set_metadata(key,value)

To Download file metadata from S3

    $ data = s3.get_metadata(key)

To Compare a file to the S3 File

    $ boolean = s3 <=> ('FILE_NAME')


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
