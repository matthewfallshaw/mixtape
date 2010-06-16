module TapesHelper
  def committed_tapesters
    @tape.tapesters.count == 0 ? "<span class='embarrassing'>- none -</span>".html_safe : @tape.tapesters.collect {|tapester| link_to(tapester.name, tapester) }.to_sentence.html_safe
  end
  def uncommitted_tapesters
    uctrs = Tapester.all - @tape.tapesters
    begin
      if (uctrs.size == 0)
               "- none - I love it when a plan comes together -".html_safe
      else
        uctrs.collect {|tapester| link_to(tapester.name, tapester) }.to_sentence
      end
    end.html_safe
  end
end
