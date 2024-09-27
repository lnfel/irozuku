RSpec.shared_context "configuration" do
  let(:white) { "#ffffff" }
  let(:crimson) { "#ff5733" }

  before do
    Irozuku.configure do |config|
      config.colors = { "rose" => white, "crimson" => crimson }
    end
  end

  after do
    Irozuku.configure do |config|
      config.colors = Irozuku::Constants::HEX_COLOR_MAP
    end
  end
end

RSpec.describe Irozuku::Configuration do
  include_context "configuration"

  it "can overwrite built-in color #{Irozuku.color("#f43f5e").write("rose")} #{Irozuku.green("to")} #{Irozuku.white("white")}" do
    expect(Irozuku.get_color("rose")).to eq(white)
  end

  it "can extend built-in colors" do
    expect(Irozuku::Validation.valid_color?("crimson")).to eq(crimson)
  end
end
