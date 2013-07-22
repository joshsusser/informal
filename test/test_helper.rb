require "test/unit"

require "rubygems"
require "bundler/setup"

require "informal/model"
require "informal/model_no_init"

Informal.suggest_active_model_model = false

require File.expand_path(File.join(File.dirname(__FILE__), "model_test_cases"))
