# Informal

Informal is a small gem that enhances a Plain Old Ruby Object so it can be used
with Rails 3 form helpers in place of an ActiveRecord model. It works with the
Rails `form_for` helper, and `simple_form` as well.

Here's a quick (and slightly insane) example:

    # models/command.rb
    require "informal"
    class Command
      include Informal::Model
      attr_accessor :command, :args
      validates_presence_of :command
      def run; `#{command} #{args}`; end
    end

    # views/commands/new.html.erb
    <%= form_for @command do |form| %>
      <%= form.text_field :command %>
      <%= form.text_field :args %>
      <%= form.submit "Do It!" %>
    <% end %>

    # controllers/commands_controller.rb
    def create
      command = Command.new(params[:command])
      if command.valid?
        command.run
      end
    end

## Installation

It's a Ruby gem, so just install it with `gem install informal`, add it to your
bundler Gemfile, or do whatever you like to do with gems. There is nothing to
configure.

## Usage

The insanity of the above example aside, Informal is pretty useful for creating
simple RESTful resources that don't map directly to ActiveRecord models. It
evolved from handling login credentials to creating model objects that were
stored in a serialized attribute of a parent resource.

In many ways using an informal model is just like using an AR model in
controllers and views. The biggest difference is that you don't `save` an
informal object, but you can add validations and check if it's `valid?`. If
there are any validation errors, the object will have all the usual error
decorations so that error messages will display properly in the form view.

### Initialization, #super and attributes

If you include `Informal::Model`, your class automatically gets an
`#initialize` method that takes a params hash and calls setters for all
attributes in the hash. If your model class inherits from a class that has its
own `#initialize` method that needs to get the super call, you should instead
include `Informal::ModelNoInit`, which does not create an `#initialize` method.
Make your own `#initialize` method, and in that you can assign the attributes
using the `#attributes=` method and also call super with whatever args are
needed.

## Overriding the `model_name`

If you name your model `InformalCommand`, form params get passed to your controller
in the `params[:informal_command]` hash. As that's a bit ugly and perhaps doesn't
play well with standing in for a real ActiveRecord model, Informal provides a
method to override the model name.

    class InformalCommand
      informal_model_name "Command"
      # ...
    end

Note: the `informal_model_name` feature is available only in Rails 3.1 or greater
(unless somebody back-ports the required API change to 3.0.x).

## Idiosyncrasies

The standard way that Rails generates ids for new records is to name them like
`command_new`, as opposed to `command_17` for persisted records. I've found that
when using informal models I often want more than one per page, and it's helpful
to have a unique id for JavaScript to use. Therefore Informal uses the model's
`object_id` to get a unique id for the record. Those ids in the DOM will look like
`command_2157193640`, which would be scary if you did anything with those memory
addresses except use them for attaching scripts.

## License

Copyright © 2011 Josh Susser. Released under the MIT License. See the LICENSE file.
