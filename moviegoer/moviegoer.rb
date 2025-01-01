# This is a custom exception that you can use in your code
class NotMovieClubMemberError < RuntimeError
end

class Moviegoer
  def initialize(age, member: false)
    @age = age
    @member = member
  end

  def ticket_price
    @age >= 60 ? 10.00 : 15.00
  end

  def watch_scary_movie?
    @age >= 18
  end

  def claim_free_popcorn!
    @member ? '🍿' : (raise NotMovieClubMemberError)
  end
end
