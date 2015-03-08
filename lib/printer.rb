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

  def self.get_horizontal_border(row, cell_size, major_or_minor = nil)
    major_or_minor = self.border_major_or_minor(major_or_minor)

    border = []
    row.each do |val|
      cell_top = ''
      cell_size.times { cell_top << major_or_minor }
      border << cell_top
    end
    border.join(ROW_INTRA_CELL_BORDER)
  end

  def self.get_row_contents(row, cell_size)
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

  # wraps two strings into a 2-item array
  def self.frame_whole_row(row, cell_size, major_or_minor = nil)
    major_or_minor = self.border_major_or_minor(major_or_minor)
    output = []
    output << self.get_horizontal_border(row, cell_size, major_or_minor)
    output << self.get_row_contents(row, cell_size)
    output
  end

  def self.corresponding_rows(row_from_b1, row_from_b2)
    output = []
    spacer = '    '

    border = ''
    border << self.get_horizontal_border(row_from_b1, 3)
    border << spacer
    border << self.get_horizontal_border(row_from_b2, 1)
    output.push(border)

    contents = ''
    b1_contents = self.get_row_contents(row_from_b1, 3)
    contents << b1_contents
    contents << spacer
    b2_contents = self.get_row_contents(row_from_b2, 1)
    contents << b2_contents
    output.push(contents)

    output
  end
  def self.concat_two_boards(options)
    b1 = options[:guess_board]
    b2 = options[:hint_board]
    b1_size = options[:b1_size] || 3
    b2_size = options[:b2_size] || 1
    spacer = self.initiate_cell(4)

    new_board = []
    b1.each_with_index do |row, ind|
      border =  self.get_horizontal_border(b1[ind], b1_size)
      border << spacer
      border << self.get_horizontal_border(b2[ind], b2_size)
      new_board.push(border)

      contents =  self.get_row_contents(b1[ind], b1_size)
      contents << spacer
      contents =  self.get_row_contents(b2[ind], b2_size)
      new_board.push(contents)
    end
    new_board
  end

  def self.print_whole_board(rows, cell_size)
    # print top row
    puts self.frame_whole_row(rows[0], cell_size, :major)
    # print rows
    rows[1..rows.length].each do |row|
      puts self.frame_whole_row(row, cell_size)
    end
  end

  def self.print_two_boards(board)
    board.each do |row|
      puts row
    end
  end

  def self.initiate_cell(size, contents = '')
    #size.times { contents << ' ' }
    contents.center(size)
  end

  def self.border_major_or_minor(major_or_minor = nil)
    case major_or_minor
    when :major
      major_or_minor = ROW_HORIZONTAL_MAJOR_BORDER
    when nil, :minor
      major_or_minor = ROW_HORIZONTAL_MINOR_BORDER
    end
    major_or_minor
  end

end
