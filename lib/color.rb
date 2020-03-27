class Color
@all_colors=[]
@all_text=[]

def self.create_data(hash)
    data=[]
    hash.each do |key, value|
        to_add = {name: key, value: value, color: Color.get_color, fill: Color.get_text}
        data<<to_add
end
data
end
def self.get_text
    Color.random_value(Color.all_text, Color.all_text_list)
end
def self.create_pie(hash, radius)
    data= Color.create_data(hash)
    puts TTY::Pie.new(data:data, radius:radius)
end
def self.get_color
    Color.random_value(Color.all_colors, Color.all_colors_list).to_sym
end


def self.random_value(all, list)
   #raise "error" if all.count ==list.count
        value= list.sample
        while all.include?(value)
            value=list.sample
        end
        all << value
        return value
end

def self.all_colors
@all_colors
end
def self.all_text
@all_text
end
def self.clear_all_colors
@all_colors=[]
end

def self.clear_all_text
@all_text=[]
end


def self.all_text_list
    chars=(('A'..'z').to_a + ('!'..'?').to_a)

end

def self.all_colors_list
  ["bright_black", "bright_red", "bright_green", "bright_yellow", "bright_blue", "bright_magenta", "bright_cyan", "bright_white"]
end
end

