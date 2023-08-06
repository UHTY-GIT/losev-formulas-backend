class ImageWithPreviewInput < Formtastic::Inputs::FileInput

  def to_html
    options.merge!(hint: preview_html.html_safe)
    super + "<script>#{preview_script}</script>".html_safe
  end

  private

  def preview_html
    <<-HTML
      <span style="display: inline-block; margin-right: 20px; vertical-align: top;">
        Current #{method}<br>
        <image src="#{object.send(method).url}" height="100" class="image_with_preview">
      </span>
      <span style="display: inline-block; vertical-align: top;">
        Selected #{method}<br>
        <img height="100" class="image_with_preview" id="#{input_html_options[:id]}_upload">
      </span>
    HTML
  end

  def preview_script
    <<-JavaScript
         $("##{input_html_options[:id]}").change(function() {
           if (this.files && this.files[0]) {
             var reader = new FileReader();
             reader.onload = function(e) {
               $('##{input_html_options[:id]}_upload').attr('src', e.target.result);
             }

             reader.readAsDataURL(this.files[0]);
           }
         });
    JavaScript
  end
end