Code.require_file "../../../test_helper.exs", __ENV__.file
defmodule Tirexs.Query.Bool.FunctionScore.Test do
  use ExUnit.Case
  import Tirexs.Query

  test :function_score do
    query = query do
      function_score(boost_mode: "avg", script_score: [script: "_score * 0.1 * (doc[\"name\"].value + 1)", lang: "expression"]) do
        query do
          dis_max do
            queries do
              term "age", 34
              term "age", 35
            end
          end
        end
        filter do
          term "tag", "green"
        end

      end
    end
    assert query == [query: [function_score: [query: [dis_max: [queries: [[term: [age: 34]],[term: [age: 35]]]]],filter: [term: [tag: "green"]], boost_mode: "avg", script_score: [script: "_score * 0.1 * (doc[\"name\"].value + 1)", lang: "expression"]]]]
  end
end
