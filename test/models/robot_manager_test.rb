require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  include TestHelpers
  def test_it_creates_a_task
    task_manager.create({
      :title       => "a title",
      :description => "a description"
    })

    task = task_manager.find(1)
    assert_equal "a title", task.title
    assert_equal "a description", task.description
    assert_equal 1, task.id
    refute task.id == 2
  end

  def test_it_returns__empty_array_for_initial_all
    all = task_manager.all
    assert_equal [], all
  end

  def test_it_returns__all_info_for_all
    task_manager.create({:title => 'eat', :description => 'i love food'})
    task_manager.create({:title => 'swim', :description => '30 minute laps'})
    task_manager.create({:title => 'yoga', :description => 'yoga sculpt at 6pm'})
    task_manager.create({:title => 'grocery shopping', :description => 'need milk'})

    all = task_manager.all

    assert_equal Task, all.first.class
    assert_equal 'eat', all.first.title
    assert_equal 'need milk', all.last.description
    # assert_equal 4, all.count
  end

  def test_find_will_create_new_task_if_id_provided
    task_manager.create({:title => 'eat', :description => 'i love food'})
    task_manager.create({:title => 'swim', :description => '30 minute laps'})
    task_manager.create({:title => 'yoga', :description => 'yoga sculpt at 6pm'})
    task_manager.create({:title => 'grocery shopping', :description => 'need milk'})

    correct_task = task_manager.find(3)
    assert_equal 'yoga', correct_task.title
    assert_equal 'yoga sculpt at 6pm', correct_task.description
    refute_equal 'eat', correct_task.title
  end

  def test_find_will_delete_based_on_id
    #assert with initial setup
    task_manager.create({:title => 'eat', :description => 'i love food'})
    task_manager.create({:title => 'swim', :description => '30 minute laps'})
    task_manager.create({:title => 'yoga', :description => 'yoga sculpt at 6pm'})
    task_manager.create({:title => 'grocery shopping', :description => 'need milk'})

    task_manager.delete(1)
    new_all = task_manager.all
    assert_equal 'swim', new_all.first.title
    refute_equal 'eat', new_all.first.title
    #add an any? assertion
  end

  def test_update_works
    task_manager.create({:title => 'eat', :description => 'i love food'})
    task = ({:title => 'cooking', :description => 'making healthy meals'})
    task_manager.update(1, task)
    assert_equal 'cooking', task_manager.all.first.title
  end

end
