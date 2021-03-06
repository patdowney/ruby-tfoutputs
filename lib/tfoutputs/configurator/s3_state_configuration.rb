require 'aws-sdk'
require 'tempfile'

module TfOutputs
  module Configurator
    class S3StateConfiguration
      :attr_accessor
      def initialize(options)
        @bucket_name = options[:bucket_name]
        @bucket_key = options[:bucket_key]
        @bucket_region = options[:bucket_region]
      end

      def save
        file = Tempfile.new('tf_state')
        s3 = Aws::S3::Client.new(region: @bucket_region)
        resp = s3.get_object bucket: @bucket_name, key: @bucket_key
        file.write(resp.body.string)
        file.rewind
        file
      end
    end
  end
end
