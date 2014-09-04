class Transaction
  attr_reader :amount, :type, :date, :source
  def initialize(amount, source, date = Time.now.strftime("%m/%d/%Y"))
    @amount = amount
    @date = date
    @source = source
  end

  def deposit?
    if amount > 0
      return true
    end
  false
  end

  def summary
    summary_string = "$"
    summary_string += sprintf("%.2f", amount.abs)
    summary_string += "\t" if summary_string.length < 8
    summary_string += "\t#{deposit? ? "DEPOSIT\t" : "WITHDRAWAL"}\t#{date} - #{source}"
    summary_string
  end


end
