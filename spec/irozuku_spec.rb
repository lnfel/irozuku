# frozen_string_literal: true

RSpec.describe Irozuku do
  it "has a version number" do
    expect(Irozuku::VERSION).not_to be nil
  end

  it "writes a string" do
    text = "Irozuku"
    expect(Irozuku.write(text)).to eq(text)
  end
end
