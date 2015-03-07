module Printer
  ROW_HORIZONTAL_MAJOR_BORDER = '='
  ROW_HORIZONTAL_MINOR_BORDER = '-'
  ROW_INTRA_CELL_BORDER = '|'

  def self.hello_world
    constant = ''
    constant << ROW_INTRA_CELL_BORDER
    constant << ROW_HORIZONTAL_MAJOR_BORDER
    constant << ROW_HORIZONTAL_MINOR_BORDER
  end

  def self.print_horizontal_border(row, major_or_minor = nil)
    major_or_minor = self.set_horizontal_border(major_or_minor)

    border = []
    row.each do |val|
      cell_top = ''
      (val.length + 2).times { cell_top << major_or_minor }
      border << cell_top
    end
    border.join(ROW_INTRA_CELL_BORDER)
  end

  def self.print_row_contents(row)
    contents = []
    row.each do |val|
      contents << (' ' << val.to_s << ' ')
    end
    contents.join(ROW_INTRA_CELL_BORDER)
  end

  def self.print_whole_row(row, major_or_minor = nil)
    major_or_minor = self.set_horizontal_border(major_or_minor)
    output = []
    output << self.print_horizontal_border(row, major_or_minor)
    output << self.print_row_contents(row)
    output
  end

  def self.print_whole_board(rows)
    # print top row
    puts self.print_whole_row(rows[0], :major)
    # print rows
    rows[1..rows.length].each do |row|
      puts self.print_whole_row(row)
    end
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
