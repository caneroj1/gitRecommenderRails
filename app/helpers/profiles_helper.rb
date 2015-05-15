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

  def favorability_string(score)
    red = score.eql?(200) ? 220 : score
    green = score.eql?(200) ? 30 : 255 - score
    width = (200 - score)/200.0 * 100

    "background-color: rgb(#{red}, #{green}, 0); width: #{width}%; height: 25px;"
  end
end
