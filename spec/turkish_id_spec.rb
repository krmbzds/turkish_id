# frozen_string_literal: true

require "spec_helper"

describe TurkishId, vcr: true do
  it "has a version number" do
    expect(TurkishId::VERSION).not_to be nil
  end

  it "accepts integer input" do
    identity_number = TurkishId.new(10_000_000_146)
    expect(identity_number.id_number).to eq([1, 0, 0, 0, 0, 0, 0, 0, 1, 4, 6])
  end

  it "accepts string input" do
    identity_number = TurkishId.new("10000000146")
    expect(identity_number.id_number).to eq([1, 0, 0, 0, 0, 0, 0, 0, 1, 4, 6])
  end

  it "generates checksum on initialization" do
    identity_number = TurkishId.new("10000000146")
    expect(identity_number.checksum).to eq([4, 6])
  end

  it "validates a valid id number" do
    identity_number = TurkishId.new("10000000146")
    expect(identity_number.valid?).to eq(true)

    identity_number = TurkishId.new("98655172890")
    expect(identity_number.valid?).to eq(true)
  end

  it "does not validate invalid id number" do
    identity_number = TurkishId.new("10001000146")
    expect(identity_number.valid?).to eq(false)
  end

  it "does not validate id number that starts with zero" do
    identity_number = TurkishId.new("00100000146")
    expect(identity_number.valid?).to eq(false)
  end

  it "does not validate empty string" do
    identity_number = TurkishId.new("")
    expect(identity_number.valid?).to eq(false)
  end

  it "does not validate nil input" do
    identity_number = TurkishId.new(nil)
    expect(identity_number.valid?).to eq(false)
  end

  it "generates elder relatives" do
    identity_number = TurkishId.new(10_000_000_146)
    expect(identity_number.elder_relative.first).to eq(10_003_000_082)
  end

  it "generates younger relatives" do
    identity_number = TurkishId.new(10_003_000_082)
    expect(identity_number.younger_relative.first).to eq(10_000_000_146)
  end

  it "generates multiple elder relatives" do
    identity_number = TurkishId.new(10_000_000_146)
    elder_relatives = identity_number.elder_relative.take(3)
    expect(elder_relatives).to eq([10_003_000_082, 10_005_999_902, 10_008_999_848])
  end

  it "generates multiple younger relatives" do
    identity_number = TurkishId.new(10_008_999_848)
    elder_relatives = identity_number.younger_relative.take(3)
    expect(elder_relatives).to eq([10_005_999_902, 10_003_000_082, 10_000_000_146])
  end

  it "does not generate relatives below 100000001cc" do
    identity_number = TurkishId.new(10_000_000_146)
    younger_relatives = identity_number.younger_relative.take(3)
    expect(younger_relatives).to eq([])
  end

  it "does not generate relatives above 999999999cc" do
    identity_number = TurkishId.new(99_997_183_780)
    elder_relatives = identity_number.elder_relative.take(3)
    expect(elder_relatives).to eq([])
  end

  it "checks government registry for valid id number" do
    identity_number = TurkishId.new(10_000_000_146)
    expect(identity_number.valid?).to eq(true)
    expect(identity_number.registered?("Gazi Mustafa Kemal Paşa", "Atatürk", 1881)).to eq(true)
  end

  it "checks government registry for numerically valid unregistered id number" do
    identity_number = TurkishId.new(99_997_183_780)
    expect(identity_number.valid?).to eq(true)
    expect(identity_number.registered?("RaveBase", "Phase 9", 1997)).to eq(false)
  end

  it "does not query government registry for invalid id number" do
    stub_any = stub_request(:any, "tckimlik.nvi.gov.tr")
    identity_number = TurkishId.new(10_000_000_000)
    expect(identity_number.valid?).to eq(false)
    expect(identity_number.registered?("Nothing", "Happened", 1989)).to eq(false)
    assert_not_requested(stub_any)
  end

  it "does not query government registry for invalid year of birth" do
    stub_any = stub_request(:any, "tckimlik.nvi.gov.tr")
    identity_number = TurkishId.new(10_000_000_146)
    expect(identity_number.valid?).to eq(true)
    expect(identity_number.registered?("Ahmet", "Yılmaz", "2nd Millennium")).to eq(false)
    assert_not_requested(stub_any)
  end

  it "does not query government registry for nil year of birth" do
    stub_any = stub_request(:any, "tckimlik.nvi.gov.tr")
    identity_number = TurkishId.new(10_000_000_146)
    expect(identity_number.valid?).to eq(true)
    expect(identity_number.registered?("Ayşe", "Yılmaz", nil)).to eq(false)
    assert_not_requested(stub_any)
  end

  it "does not query government registry for nil given name" do
    stub_any = stub_request(:any, "tckimlik.nvi.gov.tr")
    identity_number = TurkishId.new(10_000_000_146)
    expect(identity_number.valid?).to eq(true)
    expect(identity_number.registered?(nil, "Yılmaz", 2001)).to eq(false)
    assert_not_requested(stub_any)
  end

  it "does not query government registry for nil surname" do
    stub_any = stub_request(:any, "tckimlik.nvi.gov.tr")
    identity_number = TurkishId.new(10_000_000_146)
    expect(identity_number.valid?).to eq(true)
    expect(identity_number.registered?("Ayşe", nil, 2000)).to eq(false)
    assert_not_requested(stub_any)
  end
end
