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
end
