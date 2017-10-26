# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Projects', :projects_api, type: :request do
  before do
    FactoryBot.create(:project, project_name: 'Web App')
  end

  describe 'GET index' do
    it 'gets all projects' do
      get '/api/v1/projects'
      expect(response.status).to eq(200)
      expect(response.body).to be_json_response_for('project')
    end
  end

  describe 'POST create' do
    it 'creates a project' do
      post '/api/v1/projects', params: {
        data: {
          type: 'project',
          attributes: {
            project_name: 'test_app'
          }
        }
      }
      expect(response.status).to eq(201)
      expect(response.body).to be_json_response_for('project')
    end
  end

  describe 'GET show' do
    it 'shows a project' do
      get '/api/v1/projects/Web_App'
      expect(response.status).to eq(200)
      expect(response.body).to be_json_response_for('project')
    end
  end

  describe 'PUT update' do
    it 'updates a project', skip: 'todo' do
      put '/api/v1/projects/Web_App', params: {
        data: {
          type: 'project',
          attributes: {
            project_name: 'web_app'
          }
        }
      }
      expect(response.status).to eq(201)
      expect(response.body).to be_json_response_for('project')
      project_name = response.dig('data', 'attributes', 'project_name')
      expect(project_name).to eq('web_app')
    end
  end
end
