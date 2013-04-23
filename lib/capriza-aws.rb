require "capriza-aws/version"
require 'rubygems'
require 'yaml'
require 'json'
require 'aws-sdk'

module Capriza
  module Aws

    class S3connect

      def initialize (config)
        @config = config
        self.validate
        AWS.config(@config)
      end

      def validate
        if @config.kind_of?(String) and File.exist?(config_file)
          if File.exist?(config_file)
            self.read_config_file(@config)
          else
            raise "Config file #{config_file} not found"
          end
        elsif @config.kind_of?(Hash)
           puts @config
           unless @config.has_key?('access_key_id') and @config.has_key?('secret_access_key') and @config.has_key?('s3_endpoint')
            raise "Configuration missing. need the following " +
                      "access_key_id: YOUR_ACCESS_KEY_ID " +
                      "secret_access_key: YOUR_SECRET_ACCESS_KEY "  +
                      "s3_endpoint: YOUR_S3_ENDPOINT "
           end
        else
          raise("Unrecognized Format. Config can be an filename or Hash.")
        end
      end

      def read_config_file(config_file)
        case File.extname(config_file)
          when '.yaml'
            @config = YAML.load(File.read(config_file))
          when '.json'
            @config = JSON.load(File.read(config_file))
          else
            raise "Unrecognized file extension. Currently only support json and yaml"
        end
      end
    end

    class S3file
      def initialize(bucket, file_name, config)
        S3connect.new(config)
        s3 = AWS::S3.new()
        @obj = s3.buckets[bucket].objects[file_name]
      end

      def upload(data, make_public = false)
        @data = data
        @obj.write(@data)
        if make_public
          @obj.acl = :public_read
        end
      end

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
        unless File.exist?(local_file)
          raise "File #{local_file} does not exist"
        end
        @obj.etag.gsub(/\"/,"") == Digest::MD5.hexdigest(File.read(local_file))
      end

    end

  end

end
