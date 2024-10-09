RSpec.shared_context "configuration" do
  let(:white) { "#ffffff" }
  let(:crimson) { "#ff5733" }

  before do
    Irozuku.configure do |config|
      config.colors = { rose: white, crimson: crimson }
    end
  end

  after do
    Irozuku.configure do |config|
      config.colors = Irozuku::Constants::HEX_COLOR_MAP
      config.ansi_sequence = "enabled"
      config.reset_sequence = "enabled"
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

  it "enables ansi_sequence by default" do
    expect(Irozuku.configuration.ansi_sequence).to eq("enabled")
  end

  it "can disable ansi_sequence" do
    Irozuku.configure do |config|
      config.ansi_sequence = "disabled"
    end
    expect(Irozuku.configuration.ansi_sequence).to eq("disabled")
  end

  it "enables reset_sequence by default" do
    expect(Irozuku.configuration.reset_sequence).to eq("enabled")
  end

  it "can disable reset_sequence" do
    Irozuku.configure do |config|
      config.reset_sequence = "disabled"
    end
    expect(Irozuku.configuration.reset_sequence).to eq("disabled")
  end

  it "colors can accept hash rocket object" do
    Irozuku.configure do |config|
      config.colors = { "rose" => white, "crimson" => crimson }
    end
    expect(Irozuku::Validation.valid_color?("crimson")).to eq(crimson)
  end
end
