module ProfilesHelper
  def repository_icon(repo)
    if repo.is_private
      octicon("lock", true)
    elsif repo.is_forked
      octicon("repo-forked", true)
    else
      octicon("repo", true)
    end
  end

  def repository_description(repo)
    repo.description || "No description given"
  end

  def favorability_string(score, max = nil)
    max ||= 200
    red = score.eql?(max) ? 220 : score
    green = score.eql?(max) ? 30 : 255 - score
    width = (max - score)/max.to_f * 100

    "background-color: rgb(#{red}, #{green}, 0); width: #{width}%; height: 25px;"
  end
end
