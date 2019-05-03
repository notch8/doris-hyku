namespace :riiif do
  desc 'cache riiif images'
  task :cache => [:environment] do
    # load 'config/initializers/riiif.rb'
    progress = ProgressBar.create(total: Image.count)
    Image.find_each do |i|
      image_params = {"region"=>"full", "size"=>"600,", "rotation"=>"0", "quality"=>"default", "format"=>"jpg"}.with_indifferent_access
      image_id = i&.file_sets&.first&.files&.first&.uri&.to_s&.split('/')&.[](-3..-1)&.join('/')
      if image_id
        r = Riiif::Image.new(image_id)
        r.render(image_params)
      end
      progress.increment
    end
  end
end
