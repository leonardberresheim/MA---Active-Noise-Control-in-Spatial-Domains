function p_source_and_image = image_source_order(p_source, p_wall, order)
    for i=1:order
        p_source = image_source(p_source, p_wall);
    end
    p_source_and_image = p_source;
end