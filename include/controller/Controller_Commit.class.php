<?php
/**
 * GitPHP Controller Commit
 *
 * Controller for displaying a commit
 *
 * @author Christopher Han <xiphux@gmail.com>
 * @copyright Copyright (c) 2010 Christopher Han
 * @package GitPHP
 * @subpackage Controller
 */

/**
 * Commit controller class
 *
 * @package GitPHP
 * @subpackage Controller
 */
class GitPHP_Controller_Commit extends GitPHP_ControllerBase
{

	public function Initialize()
	{
		parent::Initialize();

		if (empty($this->params['hash']))
			$this->params['hash'] = 'HEAD';

		if (!empty($this->params['output']) && ($this->params['output'] == 'jstip'))
			GitPHP_Log::GetInstance()->SetEnabled(false);
	}

	/**
	 * GetTemplate
	 *
	 * Gets the template for this controller
	 *
	 * @access protected
	 * @return string template filename
	 */
	protected function GetTemplate()
	{
		if (isset($this->params['jstip']) && $this->params['jstip']) {
			return 'committip.tpl';
		}
		return 'commit.tpl';
	}

	/**
	 * GetCacheKey
	 *
	 * Gets the cache key for this controller
	 *
	 * @access protected
	 * @return string cache key
	 */
	protected function GetCacheKey()
	{
		return $this->params['hash'];
	}

	/**
	 * GetName
	 *
	 * Gets the name of this controller's action
	 *
	 * @access public
	 * @param boolean $local true if caller wants the localized action name
	 * @return string action name
	 */
	public function GetName($local = false)
	{
		if ($local && $this->resource) {
			return $this->resource->translate('commit');
		}
		return 'commit';
	}

	/**
	 * LoadData
	 *
	 * Loads data for this template
	 *
	 * @access protected
	 */
	protected function LoadData()
	{
		$commit = $this->GetProject()->GetCommit($this->params['hash']);
		$this->tpl->assign('commit', $commit);
		$this->tpl->assign('tree', $commit->GetTree());
		$treediff = $commit->DiffToParent();
		$treediff->SetRenames(true);
		$this->tpl->assign('treediff', $treediff);
	}

}
