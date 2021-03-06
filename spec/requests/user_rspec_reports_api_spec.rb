# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserRspecReports', :user_rspec_reports_api, type: :request do
  before do
    user = FactoryBot.create(:tester,
                             name: 'RspecTester',
                             email: 'user_rspec_reports@mailinator.com',
                             password: 'Qwerty12')
    project = FactoryBot.create(:project, project_name: 'Web App')
    rspec_report = FactoryBot.create(:rspec_report,
                                     version: '1.0.0',
                                     summary_line: '8 examples, 0 failures')
    report = FactoryBot.create(:report,
                               project_id: project.id,
                               reportable_type: RspecReport,
                               reportable_id: rspec_report.id,
                               status: 'passed')
    FactoryBot.create(:user_report,
                      user_id: user.id,
                      report_id: report.id)
  end
  let(:user) { User.find_by(name: 'RspecTester') }
  let(:report) { Report.first }

  describe 'GET index' do
    it 'is not authorized without X-API-KEY' do
      get "/api/v1/users/#{user.id}/reports/rspec"
      expect(response.status).to eq(401)
    end

    before do
      get "/api/v1/users/#{user.id}/reports/rspec", headers: {
        'X-API-KEY' => user.api_key
      }
    end
    let(:body) { JSON.parse(response.body).fetch('data') }

    it 'doesn\'t expose X-API-KEY' do
      api_key = body.sample.dig('attributes', 'api_key')
      expect(api_key).to be_nil
    end

    it 'gets all reports of the requested user' do
      expect(response.status).to eq(200)
      expect(response.body).to be_json_response_for('user_report')

      json_body = JSON.parse(response.body)
      summary_line = json_body.fetch('data').first
                              .dig('attributes', 'report', 'summary_line')
      expect(summary_line).to eql('8 examples, 0 failures')
    end
  end
end
