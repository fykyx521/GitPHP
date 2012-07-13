<?php
/**
 * Cache test class
 *
 * @author Christopher Han <xiphux@gmail.com>
 * @copyright Copyright (c) 2012 Christopher Han
 * @package GitPHP
 * @subpackage Test\Cache
 */
class GitPHP_CacheTest extends PHPUnit_Framework_TestCase
{
	public function testFile()
	{
		$cache = new GitPHP_Cache(new GitPHP_Cache_File(GITPHP_CACHEDIR . 'objects'));
		$cache->Clear();

		$this->assertFalse($cache->Exists('testkey1|testkey2'));
		$cache->Set('testkey1|testkey2', 'testvalue1');
		$this->assertTrue($cache->Exists('testkey1|testkey2'));
		$this->assertEquals('testvalue1', $cache->Get('testkey1|testkey2'));

		$this->assertFalse($cache->Get('testkey3|testkey4'));
		$cache->Set('testkey3|testkey4', 'testvalue2');

		$cache->Delete('testkey1|testkey2');
		$this->assertFalse($cache->Exists('testkey1|testkey2'));

		$this->assertTrue($cache->Exists('testkey3|testkey4'));

		$cache->Clear();
		$this->assertFalse($cache->Exists('testkey3|testkey4'));
	}

	public function testFileLifetime()
	{
		$cache = new GitPHP_Cache(new GitPHP_Cache_File(GITPHP_CACHEDIR . 'objects'));
		$cache->Clear();

		$cache->Set('testkey1|testkey2', 'testvalue1', 1);
		sleep(2);
		$this->assertFalse($cache->Exists('testkey1|testkey2'));

		$cache->SetLifetime(1);
		$cache->Set('testkey3|testkey4', 'testvalue2');
		sleep(2);
		$this->assertFalse($cache->Get('testkey3|testkey4'));
	}

	public function testMemcache()
	{
		$this->markTestIncomplete();
	}

	public function testMemcacheLifetime()
	{
		$this->markTestIncomplete();
	}

	public function testMemcached()
	{
		$this->markTestIncomplete();
	}

	public function testMemcachedLifetime()
	{
		$this->markTestIncomplete();
	}
}
