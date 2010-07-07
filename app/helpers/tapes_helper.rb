module TapesHelper
  def committed_tapesters
    begin
      if @tape.tapesters.count == 0
        "<span class='embarrassing'>- none -</span>"
      else
        @tape.tapesters.collect {|tapester| link_to(tapester.name, tapester) }.to_sentence
      end
    end.html_safe
  end
  def uncommitted_tapesters
    begin
      if @tape.uncommitted_tapesters.size == 0
               "- none - I love it when a plan comes together -"
      else
        @tape.uncommitted_tapesters.collect do |tapester|
          link_to(tapester.name, tapester)
        end.to_sentence
      end
    end.html_safe
  end
end
