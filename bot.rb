require 'facebook/messenger'
require 'dotenv/load'
include Facebook::Messenger

puts "ENV['ACCESS_TOKEN']: #{ENV['ACCESS_TOKEN']}"
 

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])


def wait_for_user_input
  Bot.on :message do |message|
    message.mark_seen
    puts "Received '#{message.inspect}' from #{message.sender}" 
    message.typing_on
    case message.text
      when "Hi", "hi", "hey", "Hey", "Yo", "yo", "hello"
        message.reply(text: IDIOMS[:greeting])
        message.reply(text: "I imagine you've read my stuff? Which book did you like best?",
          quick_replies: [
            {
              content_type: 'text',
              title: 'The Great Gatsby',
              payload: 'GREAT_GATSBY'
            },
            {
              content_type: 'text',
              title: 'This Side of Paradise',
              payload: 'SIDE_PARADISE'
            },
            {
              content_type: 'text',
              title: 'Tender is the Night',
              payload: 'TENDER_NIGHT'
            }
            ]
          )
      when /\sreal\b/
        message.reply(text: IDIOMS[:real])
      when /\sjoke\b/
        message.reply(text: IDIOMS[:joke])
      when /\sfortune cookie\b/
        message.reply(text: IDIOMS[:fortune_cookie])
      when /!{3,}/
        message.reply(text: IDIOMS[:exclamation])
      when /\sare you working on\b/
        message.reply(text: IDIOMS[:working_on])
      when /\slook like\b/
        message.reply(text: IDIOMS[:look_like])
      when /\sdo you believe\b/
        message.reply(text: IDIOMS[:believe])
      when /\why do you write?\b/
        message.reply(text: IDIOMS[:why_write])
      when /\sfind a job\b/
        message.reply(text: IDIOMS[:help_finding_job])
      when /\swrit\w/
        message.reply(
          attachment: {
            type: 'image',
            payload: {
              url: 'http://www.clivejames.com/files/images/fitzreading.jpg'
            }
          }
        )
        message.reply(text: IDIOMS[:writing_great_gatsby])
      when /\ssomething pretty\b/
        message.reply(text: IDIOMS[:pretty])
      when /\srepeat the past\b/
        message.reply(text: IDIOMS[:repeat_past])
      when /\sadvice\b/
        message.reply(text: IDIOMS[:advice])  
      when /\sbook choice respond\b/
        message.reply(text: IDIOMS[:book_choice_respond])
      when "Thanks", "thanks", "thx", "thank you", "Thank you", "ty"
        message.reply(text: IDIOMS[:thanks])
      when /\wou are the best\b/
        message.reply(text: IDIOMS[:the_best])
      when /\slast words\b/
        message.reply(text: IDIOMS[:last_words])
      when "The Great Gatsby"
        message.reply(text: IDIOMS[:gatsby])
      when "Tender is the Night"
          message.reply(text: IDIOMS[:tender])
      when "This Side of Paradis..."
          message.reply(text: IDIOMS[:paradise])
      else
        message.reply(text: IDIOMS[:ask_again])
    end
  end
end


IDIOMS = {
  greeting: "Why hello. Thanks for checking in on old F Scott.",
  fortune_cookie: "Never confuse a single defeat with a final defeat.",
  exclamation: "Cut out all these exclamation points. An exclamation point is like laughing at your own joke.",
  working_on: "Oh, all sorts of things. But let's not talk about plans. When you talk about plans, you take something away from them.",
  look_like: "I am the finest, loveliest, tenderest, and most beautiful person I have ever known—and even that is an understatement.",
  believe: "The test of a first-rate intelligence is the ability to hold two opposed ideas in the mind at the same time, and still retain the ability to function.",
  why_write: "You don't write because you want to say something, you write because you have something to say.",
  help_finding_job: "The idea that to make a man work you've got to hold gold in front of his eyes is a growth, not an axiom. We've done that for so long that we've forgotten there's any other way.",
  writing_great_gatsby: "To write it, it took three months; to conceive it three minutes; to collect the data in it, all my life.",
  not_up_to_standards: "I'm an intelligent dude, but obviously not up to your standards. Ask me something else.",
  advice: "Drop it like F. Scott. That's the best I got :)",
  thanks: "Why certainly. Anything else on your mind?",
  pretty: "In his blue gardens men and girls came and went like moths among the whisperings and the champagne and the stars.",
  repeat_past: "Why of course you can!",
  real: "Action is character. So...yes.",
  joke: "Ernest Hemingway",
  the_best: "No kidding. Anything else you wanted to talk about?",
  ask_again: "Alas, I don't quite understand your question. Ask me something else!",
  last_words: "And so we beat on. Boats against the current. Borne back ceaselessly into the chats.",
  gatsby: "Gatsby! What Gatsby? :) Jk, how can I help you today?",
  tender: "There's no night more tender than the ones we spend together :) How can I help you today?",
  paradise: "Good choice - may your life open up into an amazing burst of radiance :) How can I help you today?"
}


wait_for_user_input