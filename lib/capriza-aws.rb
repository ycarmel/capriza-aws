require "capriza-aws/version"
require 'rubygems'
require 'yaml'
require 'json'
require 'aws-sdk'

module Capriza
  module Aws

    class S3connect

      def initialize (config_file)
        unless File.exist?(config_file)
          raise "Config file #{config_file} not found"
        end
        if File.extname(config_file) == '.yaml'
          config = YAML.load(File.read(config_file))
        elsif File.extname(config_file) == '.json'
          config = JSON.load(File.read(config_file))
        else
          raise "Unrecognized file extension. Currently only support json and yaml"
        end
        unless config.kind_of?(Hash)
          raise "Config file #{config_file} is formatted incorrectly. Please use the following format:" +
                    "access_key_id: YOUR_ACCESS_KEY_ID" +
                    "secret_access_key: YOUR_SECRET_ACCESS_KEY"  +
                    "s3_endpoint: YOUR_S3_ENDPOINT"
        end
        AWS.config(config)
      end

    end

    class S3file
      def initialize(bucket, file_name, config_file)
        S3connect.new(config_file)
        s3 = AWS::S3.new()
        @obj = s3.buckets[bucket].objects[file_name]
      end

      def upload(data)
        @data = data
        @obj.write(@data)
      end

      def download()
        @data = @obj.read
      end

      def set_metadata(key,value)
        @obj.metadata[key] = value
      end

      def get_metadata(key)
        @obj.metadata[key]
      end

      def <=> (local_file)
        if ! File.exist?(local_file)
          raise "File #{local_file} does not exist"
        end
        @obj.etag.gsub(/\"/,"") == Digest::MD5.hexdigest(File.read(local_file))
      end

    end

  end

end
