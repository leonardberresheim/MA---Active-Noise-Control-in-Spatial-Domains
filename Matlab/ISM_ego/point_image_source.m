function point_image_source(p_source, p_wall, image_order, p_receiver, frequency, dimention, spacing)
    p_source = image_source_order(p_source, p_wall, image_order);
    point_source(p_source, p_receiver, frequency, dimention, spacing);
end