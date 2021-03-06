require('pg')

class Sqlrunner

  def Sqlrunner.run(sql, values =[])
    begin
      db = PG.connect({dbname: 'codeclan_cinema',
                       host: 'localhost'})

      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure
      db.close
    end
    return result
  end

end
