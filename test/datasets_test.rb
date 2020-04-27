require_relative "test_helper"

class DatasetsTest < Minitest::Test
  def test_mnist
    trainset = TorchVision::Datasets::MNIST.new(root, train: true, download: true)
    assert_equal 60000, trainset.size
    assert_kind_of MiniMagick::Image, trainset[0][0]
    assert_equal 5, trainset[0][1]

    testset = TorchVision::Datasets::MNIST.new(root, train: false, download: true)
    assert_equal 10000, testset.size
    assert_kind_of MiniMagick::Image, testset[0][0]
    assert_equal 7, testset[0][1]
  end

  def test_missing
    error = assert_raises(TorchVision::Error) do
      TorchVision::Datasets::MNIST.new(Dir.mktmpdir)
    end
    assert_equal "Dataset not found. You can use download: true to download it", error.message
  end

  def root
    @root ||= Dir.tmpdir
  end
end