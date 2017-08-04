require 'facebook/messenger'
require 'dotenv/load'
include Facebook::Messenger
# NOTE: ENV variables should be set directly in terminal for testing on localhost

Facebook::Messenger.configure do |config|
  config.access_token = ENV['ACCESS_TOKEN']
  config.verify_token = ENV['VERIFY_TOKEN']
end
 
# Subcribe bot to your page
Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

def wait_for_user_input
  Bot.on :message do |message|
    puts "Received '#{message.inspect}' from #{message.sender}" 
    case message.text
      when "Hi", "hi", "hey", "Hey", "Yo", "yo"
        message.reply(text: IDIOMS[:greeting])
      when /\sfortune cookie\b/
        message.reply(text: IDIOMS[:fortune_cookie])
      when /!{3,}/
        message.reply(text: IDIOMS[:exclamation])
      when /\sare you working on\b/
        message.reply(text: IDIOMS[:working_on])
      when /\wo you like me\b/
        message.reply(text: IDIOMS[:like_me])
      when /\sdo you believe\b/
        message.reply(text: IDIOMS[:believe])
      when /\why do you write?\b/
        message.reply(text: IDIOMS[:why_write])
      when /\sfind a job\b/
        message.reply(text: IDIOMS[:help_finding_job])
      when /\swrit\w/
        message.reply(text: IDIOMS[:writing_great_gatsby])
      when /\way something pretty\b/
        message.reply(text: IDIOMS[:pretty])
      when /\srepeat the past\b/
        message.reply(text: IDIOMS[:repeat_past])
      when /\sadvice\b/
        message.reply(text: IDIOMS[:advice])  
      else
        message.reply(text: IDIOMS[:not_up_to_standards])
        # show_replies_menu(MENU_REPLIES)
    end
  end
end

# def show_apology_and_reply_options
#   Bot.on :message do |message|
#     show_replies_menu(message.sender['id'], MENU_REPLIES)
#   end 
# end

IDIOMS = {
  greeting: "Why hello. What do you want to know?",
  fortune_cookie: "Never confuse a single defeat with a final defeat.",
  exclamation: "Cut out all these exclamation points. An exclamation point is like laughing at your own joke.",
  working_on: "Oh, all sorts of things. But let's not talk about plans. When you talk about plans, you take something away from them.",
  like_me: "You are the finest, loveliest, tenderest, and most beautiful person I have ever known—and even that is an understatement.",
  believe: "The test of a first-rate intelligence is the ability to hold two opposed ideas in the mind at the same time, and still retain the ability to function.",
  why_write: "You don't write because you want to say something, you write because you have something to say.",
  help_finding_job: "The idea that to make a man work you've got to hold gold in front of his eyes is a growth, not an axiom. We've done that for so long that we've forgotten there's any other way.",
  writing_great_gatsby: "To write it, it took three months; to conceive it three minutes; to collect the data in it, all my life.",
  not_up_to_standards: "I'm an intelligent dude, but obviously not up to your standards. Ask me something else.",
  advice: "Drop it like F. Scott.",
  pretty: "In his blue gardens men and girls came and went like moths among the whisperings and the champagne and the stars.",
  repeat_past: "Why of course you can!"
}

MENU_REPLIES = [
  {
    content_type: 'text',
    title: 'Got any advice?',
    payload: 'ADVICE'
    },
  {
    content_type: 'text',
    title: 'Say something pretty.',
    payload: 'PRETTY'
  },
  {
    content_type: 'text',
    title: 'Can I repeat the past?',
    payload: 'REPEAT_PAST'
  }
]

# def say(recipient_id, text, quick_replies = nil)
#   message_options = {
#   recipient: { id: recipient_id },
#   message: { text: text }
#   }
#   if quick_replies
#     message_options[:message][:quick_replies] = quick_replies
#   end
#   Bot.deliver(message_options, access_token: ENV['ACCESS_TOKEN'])
# end

# def show_replies_menu(quick_replies)
#   say(id, IDIOMS[:not_up_to_standards], quick_replies)
#   wait_for_user_input 
# end

wait_for_user_input