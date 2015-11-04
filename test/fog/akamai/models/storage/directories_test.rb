require 'test_helper'
require 'helpers/dir_request_stub'

class Fog::Storage::Akamai::DirectoriesTest < Minitest::Test
  include DirRequestStub

  def setup
    stub_dir('/42/path')
  end

  def test_get_will_return_a_directory_with_the_correct_key
    assert_equal '/path', Fog::Storage[:akamai].directories.get('/path').key
  end

  def test_get_will_load_files
    assert_equal 2, Fog::Storage[:akamai].directories.get('/path').files.count
  end

  def test_get_will_set_the_directory
    directory = Fog::Storage[:akamai].directories.get('/path')
    assert_equal [directory, directory], directory.files.map(&:directory)
  end
end
