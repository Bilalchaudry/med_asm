require 'csv'

class Product < ApplicationRecord

  has_many :product_categories
  has_many :categories, through: :product_categories


  has_many :order_products
  has_many :orders, through: :order_products


  validates_presence_of :name, :cost, :quantity


  def self.import_file(file)
    begin
      if File.extname(file.original_filename) == '.csv'
        csv_text = File.read(file.path)
        if String.method_defined?(:encode)
          csv_text.encode!('UTF-8', 'UTF-8', :invalid => :replace)
        end
        csv = CSV.parse(csv_text, :headers => true)
        i = 0
        @products = []
        i = 0
        csv.each do |row|
          begin
            i = i + 1
            if row[0].present?
              medicine = Product.where("lower(name) = ?", row[0].strip.downcase).first
              if medicine.present?
                return error = "Validation Failed. Medicine name already exist. Error on Row: #{i}"
              end
            else
              return error = "Validation Failed. Name Empty in File. Error on Row: #{i}"
            end

            new_product = @products.any? {|product| product.name == row[2]}
            if new_product
              return error = "Validation Failed. Name Already Exist in File, Error on Row: #{i}"
            end

            if row[1].nil?
              return error = "Validation Failed. Description Empty in File, Error on Row: #{i}"
            end

            if row[2].nil?
              return error = "Validation Failed. Cost Empty in File, Error on Row: #{i}"
            end

            unless row[2].to_i > 0
              return error = "Validation Failed. Cost must be greater than 0, Error on Row: #{i}"
            end

            if row[3].nil?
              return error = "Validation Failed. Quantity Empty in File, Error on Row: #{i}"
            end

            unless row[3].to_i > 0
              return error = "Validation Failed. Quantity must be greater than 0, Error on Row: #{i}"
            end

            if row[4].nil?
              return error = "Validation Failed. Category Empty in file, Error on Row: #{i}"
            end
            category = Category.find_by_name(row[4])
            if category.nil?
              return error = "Validation Failed. Category not found, Error on Row: #{i}"
            end

            @products << Product.new(name: row[0], description: row[1], cost: row[2], quantity: row[3], category: category.id)

          rescue => e
            return e.message
          end
        end
        if @products.empty?
          return error = "Validation Failed. Please Insert some data in File."
        end

        @products.each do |product|
          ProductCategory.create(product_id: product.id, category_id: product.category)
          Product.create(name: product.name, description: product.description,
                         cost: product.cost, quantity: product.quantity)
        end

        error = 'Data imported successfully!'
      else
        error = 'Invalid File Format. Please Import CSV Successfully'
      end
    rescue => e
      error = e.message
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then
      Roo::CSV.new(file.path, nil, :ignore)
    when ".xlsx" then
      Roo::Excelx.new(file.path)
    when ".xls" then
      Roo::Excel.new(file.path)
    else
      return false
    end
  end


end