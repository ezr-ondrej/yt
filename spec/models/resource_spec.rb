require 'spec_helper'
require 'yt/models/resource'

describe Yt::Resource do
  subject(:resource) { Yt::Resource.new attrs }

  context 'given a resource initialized with a URL (containing an ID)' do
    let(:attrs) { {url: 'youtu.be/MESycYJytkU'} }

    it { expect(resource.id).to eq 'MESycYJytkU' }
    it { expect(resource.kind).to eq 'video' }
    it { expect(resource.username).to be_nil }
  end

  context 'given a resource initialized with a URL (containing a username)' do
    let(:attrs) { {url: 'youtube.com/fullscreen'} }

    it { expect(resource.kind).to eq 'channel' }
    it { expect(resource.username).to eq 'fullscreen' }
  end

  describe '#public?' do
    context 'given fetching a status returns privacyStatus "public"' do
      let(:attrs) { {status: {"privacyStatus"=>"public"}} }
      it { expect(resource).to be_public }
    end

    context 'given fetching a status does not return privacyStatus "public"' do
      let(:attrs) { {status: {}} }
      it { expect(resource).not_to be_public }
    end
  end

  describe '#private?' do
    context 'given fetching a status returns privacyStatus "private"' do
      let(:attrs) { {status: {"privacyStatus"=>"private"}} }
      it { expect(resource).to be_private }
    end

    context 'given fetching a status does not return privacyStatus "private"' do
      let(:attrs) { {status: {}} }
      it { expect(resource).not_to be_private }
    end
  end

  describe '#unlisted?' do
    context 'given fetching a status returns privacyStatus "unlisted"' do
      let(:attrs) { {status: {"privacyStatus"=>"unlisted"}} }
      it { expect(resource).to be_unlisted }
    end

    context 'given fetching a status does not return privacyStatus "unlisted"' do
      let(:attrs) { {status: {}} }
      it { expect(resource).not_to be_unlisted }
    end
  end
end