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
    ansi = Irozuku.hex_to_ansi(Irozuku::Constants::HEX_COLOR_MAP[:emerald])
    expect(ansi.match?(/(\d*);(\d*);(\d*)/)).to eq(true)
  end

  context "when using built-in colors" do
    Irozuku::Constants::HEX_COLOR_MAP.each do |key, value|
      it "colors the text #{Irozuku.bold.public_send(key, key)}" do
        if Irozuku.respond_to?(key)
          output = Irozuku.public_send(key, "Irozuku")
        end
        expect { print output }.to output(output).to_stdout
      end
    end
  end

  context "when using text decorations" do
    Irozuku::Constants::TEXT_DECORATION_MAP.each do |key, value|
      it "applies #{Irozuku.public_send(key, key)} to text" do
        if Irozuku.respond_to?(key)
          output = Irozuku.public_send(key, key)
        end
        expect { print output }.to output(output).to_stdout
      end
    end
  end

  context "when using built-in background colors" do
    Irozuku::Constants::HEX_COLOR_MAP.each do |key, value|
      it "colors the background #{key} #{Irozuku.public_send(:"bg_#{key}", " ")}" do
        if Irozuku.respond_to?(:"bg_#{key}")
          output = Irozuku.public_send(:"bg_#{key}", key)
        end
        expect { print output }.to output(output).to_stdout
      end
    end
  end

  context "when chaining methods" do
    Irozuku::Constants::TEXT_DECORATION_MAP.each do |key, value|
      it "#{key} method can be chained" do
        expect(Irozuku.public_send(key)).to eq(Irozuku)
      end
    end

    Irozuku::Constants::HEX_COLOR_MAP.each do |key, value|
      it "#{key} method can be chained" do
        expect(Irozuku.public_send(key)).to eq(Irozuku)
      end

      it "bg_#{key} method can be chained" do
        expect(Irozuku.public_send(:"bg_#{key}")).to eq(Irozuku)
      end
    end

    it "color method can be chained" do
      expect(Irozuku.color("red")).to eq(Irozuku)
    end
  end

  context "when validating color strings" do
    it "raises an error for invalid hex color string" do
      invalid_hex_color = "#IROZUKU"
      expect { Irozuku.color(invalid_hex_color).write("YATTA!!!") }.to raise_error(Irozuku::Validation::ValidationError, "Invalid hex color string: #{invalid_hex_color}")
    end

    it "raises an error for invalid color name" do
      invalid_color_name = "something_red"
      expect { Irozuku.color(invalid_color_name).write("RED") }.to raise_error(Irozuku::Validation::ValidationError, "Color #{invalid_color_name} is not defined.")
    end
  end

  context "when configuring Irozuku" do
    it "configure method returns nil when no block is given" do
      expect(Irozuku.configure).to eq(nil)
    end
  end
end

RSpec.describe Irozuku::IrozukuError do
  it "extends from StandardError" do
    a = Irozuku::IrozukuError.new("Something happened")
    expect(a.class.superclass).to eq(StandardError)
  end
end
