# Slice a sprite into 9 pieces, and render them to the output area, scaled to fit.
#
# @note Slice coordinates are from the TOP LEFT of the sprite. Output coordinates are from the normal Bottom Left.
#
# @param args [Hash] The args hash
# @param path [String] The path to the sprite
# @param x1 [Integer] The X coordinate of the first vertical slice
# @param x2 [Integer] The X coordinate of the second vertical slice
# @param y1 [Integer] The Y coordinate of the first horizontal slice
# @param y2 [Integer] The Y coordinate of the second horizontal slice
# @param w [Integer] The width of the sprite
# @param h [Integer] The height of the sprite
# @param output_x [Integer] The X coordinate of the output area
# @param output_y [Integer] The Y coordinate of the output area
# @param output_w [Integer] The width of the output area
# @param output_h [Integer] The height of the output area
def nine_slice(args, path:, x1:, x2:, y1:, y2:, w:, h:, output_x:, output_y:, output_w:, output_h:)
  upper_left_slice = {x: 0, y: 0, w: x1, h: y1}
  upper_middle_slice = {x: x1, y: 0, w: x2 - x1, h: y1}
  upper_right_slice = {x: x2, y: 0, w: w - x2, h: y1}

  middle_left_slice = {x: 0, y: y1, w: x1, h: y2 - y1}
  middle_middle_slice = {x: x1, y: y1, w: x2 - x1, h: y2 - y1}
  middle_right_slice = {x: x2, y: y1, w: w - x2, h: y2 - y1}

  lower_left_slice = {x: 0, y: y2, w: x1, h: h - y2}
  lower_middle_slice = {x: x1, y: y2, w: x2 - x1, h: h - y2}
  lower_right_slice = {x: x2, y: y2, w: w - x2, h: h - y2}

  # Calculate the top Y value. Our coordinates are flipped between the sprite and the output, so we need to flip the Y value.
  top_y = output_y + output_h - y1

  # Upper left sprite is a non-stretched sprite
  args.outputs.sprites << {x:output_x, y:top_y, w:upper_left_slice.w, h:upper_left_slice.h, path:path, tile_x:0, tile_y:0, tile_w:upper_left_slice.w, tile_h:upper_left_slice.h}

  # Upper middle sprite is a stretched sprite
  args.outputs.sprites << {x:output_x + upper_left_slice.w, y:top_y, w:output_w - upper_left_slice.w - upper_right_slice.w, h:upper_middle_slice.h, path:path, tile_x:upper_left_slice.w, tile_y:0, tile_w:upper_middle_slice.w, tile_h:upper_middle_slice.h}

  # Upper right sprite is a non-stretched sprite
  args.outputs.sprites << {x:output_x + output_w - upper_right_slice.w, y:top_y, w:upper_right_slice.w, h:upper_right_slice.h, path:path, tile_x:upper_right_slice.x, tile_y:upper_right_slice.y, tile_w:upper_right_slice.w, tile_h:upper_right_slice.h}

  middle_y = output_y + lower_left_slice.h
  # Middle left sprite is a stretched sprite
  args.outputs.sprites << {x:output_x, y:middle_y, w:middle_left_slice.w, h:output_h - upper_left_slice.h - lower_left_slice.h, path:path, tile_x:0, tile_y:upper_left_slice.h, tile_w:middle_left_slice.w, tile_h:middle_left_slice.h}

  # Middle middle sprite is a stretched sprite
  args.outputs.sprites << {x:output_x + middle_left_slice.w, y:middle_y, w:output_w - middle_left_slice.w - middle_right_slice.w, h:output_h - upper_middle_slice.h - lower_middle_slice.h, path:path, tile_x:middle_middle_slice.x, tile_y:middle_middle_slice.y, tile_w:middle_middle_slice.w, tile_h:middle_middle_slice.h}

  # Middle right sprite is a stretched sprite
  args.outputs.sprites << {x:output_x + output_w - middle_right_slice.w, y:middle_y, w:middle_right_slice.w, h:output_h - upper_right_slice.h - lower_right_slice.h, path:path, tile_x:middle_right_slice.x, tile_y:middle_right_slice.y, tile_w:middle_right_slice.w, tile_h:middle_right_slice.h}

  lower_y = output_y
  # Lower left sprite is a non-stretched sprite
  args.outputs.sprites << {x:output_x, y:lower_y, w:lower_left_slice.w, h:lower_left_slice.h, path:path, tile_x:lower_left_slice.x, tile_y:lower_left_slice.y, tile_w:lower_left_slice.w, tile_h:lower_left_slice.h}

  # Lower middle sprite is a stretched sprite
  args.outputs.sprites << {x:output_x + lower_left_slice.w, y:lower_y, w:output_w - lower_left_slice.w - lower_right_slice.w, h:lower_middle_slice.h, path:path, tile_x:lower_middle_slice.x, tile_y:lower_middle_slice.y, tile_w:lower_middle_slice.w, tile_h:lower_middle_slice.h}

  # Lower right sprite is a non-stretched sprite
  args.outputs.sprites << {x:output_x + output_w - lower_right_slice.w, y:lower_y, w:lower_right_slice.w, h:lower_right_slice.h, path:path, tile_x:lower_right_slice.x, tile_y:lower_right_slice.y, tile_w:lower_right_slice.w, tile_h:lower_right_slice.h}
end
