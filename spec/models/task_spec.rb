# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task do
  let(:task) { Task.new }
  it 'does not have a new task as complete' do
    expect(task).not_to be_complete
  end

  it 'allows us to complete a task' do
    task.mark_completed
    expect(task).to be_complete
  end

  describe 'velocity' do
    let(:task) { Task.new(size: 3) }
    it 'does not count an incomplete task towards velocity' do
      expect(task).not_to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(0)
    end

    it 'counts recently completed tasks towards velocity' do
      task.mark_completed(1.day.ago)
      expect(task).to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(3)
    end

    it 'does not count a long ago completed task toward velocity' do
      task.mark_completed(6.months.ago)
      expect(task).not_to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(0)
    end
  end
end
