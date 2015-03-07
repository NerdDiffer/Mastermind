module Printer
  require 'colorize'

  ROW_HORIZONTAL_MAJOR_BORDER = '='
  ROW_HORIZONTAL_MINOR_BORDER = '-'
  ROW_INTRA_CELL_BORDER = '|'

  def self.hello_world
    constant = ''
    constant << ROW_INTRA_CELL_BORDER
    constant << ROW_HORIZONTAL_MAJOR_BORDER
    constant << ROW_HORIZONTAL_MINOR_BORDER
  end

  def self.print_horizontal_border(row, cell_size, major_or_minor = nil)
    major_or_minor = self.set_horizontal_border(major_or_minor)

    border = []
    row.each do |val|
      cell_top = ''
      cell_size.times { cell_top << major_or_minor }
      border << cell_top
    end
    border.join(ROW_INTRA_CELL_BORDER)
  end

  def self.print_row_contents(row, cell_size)
    contents = []
    row.each do |val|
      if val == :black || val == :white
        str = cell_size % 2 == 0 ? val.to_s[0..1] : val.to_s[0]
        cell = self.initiate_cell(cell_size, str.capitalize)
      else
        cell = self.initiate_cell(cell_size)
      end
      contents << cell.colorize(:background => val)
    end
    contents.join(ROW_INTRA_CELL_BORDER)
  end

  def self.print_whole_row(row, cell_size, major_or_minor = nil)
    major_or_minor = self.set_horizontal_border(major_or_minor)
    output = []
    output << self.print_horizontal_border(row, cell_size, major_or_minor)
    output << self.print_row_contents(row, cell_size)
    output
  end

  def self.print_whole_board(rows, cell_size)
    # print top row
    puts self.print_whole_row(rows[0], cell_size, :major)
    # print rows
    rows[1..rows.length].each do |row|
      puts self.print_whole_row(row, cell_size)
    end
  end

  def self.initiate_cell(size, contents = '')
    #size.times { contents << ' ' }
    contents.center(size)
  end

  def self.set_horizontal_border(major_or_minor = nil)
    case major_or_minor
    when :major
      major_or_minor = ROW_HORIZONTAL_MAJOR_BORDER
    when nil, :minor
      major_or_minor = ROW_HORIZONTAL_MINOR_BORDER
    end
    major_or_minor
  end

end
