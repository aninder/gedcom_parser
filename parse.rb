class Parse
  def self.parse(gedcom)
    @xml="<gedcom>"
    prevLevel=[]
    prevTag=[]
    gedArr=gedcom.split("\n")
    gedArr.each do |line|
      line=line.split
      if line[1] =~ /^@/
        id = line[1][/@(.*)@/,1]
        @xml << "<#{line[2].downcase} id=#{id}>"
        prevLevel.push line[0]
        prevTag.push line[2]
      else
        if prevLevel.last < line[0]
          addandpush(line, prevLevel, prevTag)
          elsif prevLevel.last == line[0]
            @xml << "</#{prevTag.pop.downcase}>"
            prevLevel.pop
            addandpush(line, prevLevel, prevTag)
          elsif prevLevel.last > line[0]
            while prevLevel.last >= line[0]
              @xml << "</#{prevTag.pop.downcase}>"
              prevLevel.pop
            end
            addandpush(line, prevLevel, prevTag)
        end
      end
    end
    while prevTag.length > 0
      @xml << "</#{prevTag.pop.downcase}>"
    end
    @xml << "</gedcom>"
    end

  def self.addandpush(line, prevLevel, prevTag)
    @xml << "<#{line[1].downcase}>"
    @xml << "#{line[2..line.length].join(" ")}"
    prevLevel.push line[0]
    prevTag.push line[1]
  end
end