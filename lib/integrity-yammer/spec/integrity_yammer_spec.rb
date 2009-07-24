require File.dirname(__FILE__) + "/spec_helper"

describe Integrity::Notifier::Yammer do
  include AppSpecHelper
  include NotifierSpecHelper
  
  it_should_behave_like "A notifier"

  def klass
    Integrity::Notifier::Yammer
  end
  
  describe "notifying the world of a build" do
    before { klass.stub!(:new).and_return(notifier) }
    
    it "should instantiate a notifier with the given build and config" do
      klass.should_receive(:new).with(mock_build, anything).and_return(notifier)
      klass.notify_of_build(mock_build, notifier_config)
    end
  
    it "should pass the notifier options to the notifier" do
      klass.should_receive(:new).with(anything, notifier_config).and_return(notifier)
      klass.notify_of_build(mock_build, notifier_config)
    end
    
    it "should deliver the notification" do
      notifier.should_receive(:deliver!)
      klass.notify_of_build(mock_build, notifier_config)
    end
  end
  
  describe "generating a form for configuration" do  
    describe "with a field for the oauth yaml file" do
      it "should have the proper name, id and label" do
        the_form.should have_textfield("integrity_yammer_notify_oauth_yml").named("notifiers[Yammer][oauth_yml]").with_label("Oauth Yaml File").with_value("yammer_oauth.yml")
      end

      it "should use the config's 'oauth_yml' value if available" do
        the_form(:config => { 'oauth_yml' => 'oauth.yml' }).should have_textfield("integrity_yammer_notifier_oauth_yml").with_value("oauth.yml")
      end
    end
   end
end
