# frozen_string_literal: true

RSpec.describe Irozuku do
  it "has a version number" do
    expect(Irozuku::VERSION).not_to be nil
  end

  it "writes a plain string" do
    text = "Irozuku"
    expect(Irozuku.write(text)).to eq(text)
  end

  it "converts hex_string to ansi" do
    ansi = Irozuku.hex_to_ansi(Irozuku::Constants::HEX_COLOR_MAP["emerald"])
    expect(ansi.match?(/(\d*);(\d*);(\d*)/)).to eq(true)
  end
end
