RSpec.describe Irozuku::Utils do
  it "can silence $stdout" do
    message = "Annoying message!!!"
    captured_output = Irozuku::Utils.silence_stdout do
      print message
    end

    expect(captured_output).to eq(message)
  end
end
