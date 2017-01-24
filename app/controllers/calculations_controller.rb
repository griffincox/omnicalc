class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.delete(' ').delete("\r\n").length

    @word_count = @text.split(' ').length

    @occurrences = occurences_fn(@text, @special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def occurences_fn(array, target_string)
    num_occurences = 0;
    array.downcase.split(' ').each do |object|
      if object == target_string.downcase
        num_occurences +=1;
      end
    end
    return num_occurences
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    @apr_percent = @apr/100
    @rate_percent = @apr_percent/12
    @months = @years * 12
    @monthly_payment = @principal*@rate_percent/(1-1/(1+@rate_percent)**(@months))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================
    @time_between = @ending - @starting
    @seconds = @time_between.seconds
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @sorted_numbers = @numbers.sort()

    @count = @numbers.length

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @maximum - @minimum

    @median = median_finder(@numbers)

    @sum = @numbers.sum

    @mean = @sum/@count

    @variance = variance_finder(@numbers)
    # credit: http://stackoverflow.com/questions/7749568/how-can-i-do-standard-deviation-in-ruby

    @standard_deviation = Math.sqrt(@variance)
    # credit: http://stackoverflow.com/questions/7749568/how-can-i-do-standard-deviation-in-ruby

    @mode = mode_finder(@numbers)[0]
    # credit: http://stackoverflow.com/questions/25343374/finding-the-mode-of-a-ruby-array-simplified

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end

  def median_finder(array)
    len = array.length
    if len % 2 == 0
      return ((array[len/2] + array[len/2+1])/2)
    else
      return array[len/2]
    end
  end

  def variance_finder(array)
    mean = array.inject(:+) / array.length.to_f
    var_sum = array.map{|n| (n-mean)**2}.inject(:+).to_f
    sample_variance = var_sum / (array.length)
    return sample_variance
  end

  def mode_finder(array)
    array.group_by{ |e| e }.group_by{ |k, v| v.size }.max.pop.map{ |e| e.shift }
  end
end
