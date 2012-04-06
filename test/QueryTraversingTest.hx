package;

import massive.munit.Assert;

import DOMTools;
using DOMTools;
import domtools.Query;

/**
* Auto generated ExampleTest for MassiveUnit. 
* This is an example test class can be used as a template for writing normal and async tests 
* Refer to munit command line tool for more information (haxelib run munit)
*/
class QueryTraversingTest 
{
	public function new() 
	{
	}
	
	@BeforeClass
	public function beforeClass():Void
	{
		// trace ("BeforeClass");
	}
	
	@AfterClass
	public function afterClass():Void
	{
		// trace ("AfterClass");
	}

	var sampleDocument:Query;
	var nullQuery:Query;
	var emptyQuery:Query;
	
	@Before
	public function setup():Void
	{
		var sampleDocument = "<myxml>
			<h1>Title</h1>
			<ul id='a'>
				<li id='a1'>1</li>
				<li id='a2' class='pickme'>2</li>
				<li id='a3'>3</li>
				<li id='a4'>4</li>
			</ul>
			<ul id='b'>
				<li id='b1'>1</li>
				<li id='b2' class='pickme'>2</li>
				<li id='b3'>3</li>
				<li id='b4'>4</li>
			</ul>
			<div id='empty1' class='empty'></div>
			<div id='empty2' class='empty'></div>
			<div id='nonElements'>Before<!--Comment-->After</div>
			<div id='recursive' class='level1'>
				<div class='level2'>
					<div class='level3'>
						<div class='level4'>
						</div>
					</div>
				</div>
			</div>
		</myxml>".parse();
		nullQuery = null;
		emptyQuery = new Query();

		Query.setDocument(sampleDocument.getNode());

	}
	
	@After
	public function tearDown():Void
	{
		// trace ("Tear Down");
	}

	@Test 
	public function children_normal()
	{
		var q1 = 'ul'.find().children();
		Assert.areEqual(8, q1.length);
	}

	@Test 
	public function children_elementsOnly()
	{
		var q1 = '#nonElements'.find().children();
		var q2 = '#nonElements'.find().children(false);
		Assert.areEqual(0, q1.length);
		Assert.areEqual(3, q2.length);
	}

	@Test 
	public function children_onNull()
	{
		Assert.areEqual(0, nullQuery.children().length);
	}

	@Test 
	public function children_onEmptyParent()
	{
		var q1 = ".empty".find();
		Assert.areEqual(2, q1.length);
		Assert.areEqual(0, q1.children().length);
	}

	@Test 
	public function children_onEmptyCollection()
	{
		Assert.areEqual(0, emptyQuery.children().length);
	}

	@Test 
	public function firstChildren()
	{
		var q1 = "ul".find().firstChildren();
		Assert.areEqual(2, q1.length);
		Assert.areEqual("a1", q1.eq(0).attr('id'));
		Assert.areEqual("b1", q1.eq(1).attr('id'));
	}

	@Test 
	public function firstChildren_elementsOnly()
	{
		var q1 = '#nonElements'.find().firstChildren();
		var q2 = '#nonElements'.find().firstChildren(false);
		Assert.areEqual(0, q1.length);
		Assert.areEqual(1, q2.length);
	}

	@Test 
	public function firstChildren_onNull()
	{
		Assert.areEqual(0, nullQuery.firstChildren().length);
	}

	@Test 
	public function firstChildren_onEmptyParent()
	{
		var q1 = ".empty".find();
		Assert.areEqual(2, q1.length);
		Assert.areEqual(0, q1.firstChildren().length);
	}

	@Test 
	public function firstChildren_onEmptyCollection()
	{
		Assert.areEqual(0, emptyQuery.firstChildren().length);
	}

	@Test 
	public function lastChildren()
	{
		var q1 = "ul".find().lastChildren();
		Assert.areEqual(2, q1.length);
		Assert.areEqual("a4", q1.eq(0).attr('id'));
		Assert.areEqual("b4", q1.eq(1).attr('id'));
	}

	@Test 
	public function lastChildren_elementsOnly()
	{
		var q1 = '#nonElements'.find().lastChildren();
		var q2 = '#nonElements'.find().lastChildren(false);
		Assert.areEqual(0, q1.length);
		Assert.areEqual(1, q2.length);
	}

	@Test 
	public function lastChildren_onNull()
	{
		Assert.areEqual(0, nullQuery.lastChildren().length);
	}

	@Test 
	public function lastChildren_onEmptyCollection()
	{
		Assert.areEqual(0, emptyQuery.lastChildren().length);
	}

	@Test 
	public function lastChildren_onEmptyParent()
	{
		var q1 = ".empty".find();
		Assert.areEqual(2, q1.length);
		Assert.areEqual(0, q1.lastChildren().length);
	}

	@Test 
	public function parent()
	{
		var l4 = ".level4".find();
		Assert.isTrue(l4.parent().hasClass('level3'));
	}

	@Test 
	public function parent_onNull()
	{
		Assert.areEqual(0, nullQuery.parent().length);
	}

	@Test 
	public function parent_onEmptyCollection()
	{
		Assert.areEqual(0, emptyQuery.parent().length);
	}

	@Test 
	public function parent_onElementWithNoParent()
	{
		// eg Document
		var doc:Node = untyped __js__('document');
		var q = new Query(doc);
		Assert.areEqual(0, q.parent().length);
	}

	@Test 
	public function ancestors()
	{
		var l4 = ".level4".find();
		var a = l4.ancestors();
		Assert.areEqual(4, a.length);
		Assert.isTrue(a.eq(0).hasClass('level3'));
		Assert.isTrue(a.eq(1).hasClass('level2'));
		Assert.isTrue(a.eq(2).hasClass('level1'));
		Assert.areEqual("myxml", a.eq(3).tagName());
	}

	@Test 
	public function ancestors_onNull()
	{
		Assert.areEqual(0, nullQuery.ancestors().length);
	}

	@Test 
	public function ancestors_onEmptyCollection()
	{
		Assert.areEqual(0, emptyQuery.ancestors().length);
	}

	@Test 
	public function ancestors_onElementWithNoParents()
	{
		// eg Document
		var doc:Node = untyped __js__('document');
		var q = new Query(doc);
		var a = q.ancestors();
		Assert.areEqual(0, a.length);
	}

	@Test 
	public function next()
	{
		for (li in ".pickme".find())
		{
			Assert.areEqual("3", li.toQuery().next().text());
		}
	}

	@Test 
	public function next_onNull()
	{
		Assert.areEqual(0, nullQuery.next().length);
	}

	@Test 
	public function next_onEmpty()
	{
		Assert.areEqual(0, emptyQuery.next().length);
	}

	@Test 
	public function next_onLast()
	{
		var q = new Query();
		q.addCollection('#a4'.find()); // no next()
		q.addCollection('#b4'.find()); // no next()
		q.addCollection('#b3'.find()); // next() = '#b4'
		Assert.areEqual(1, q.next().length);
		Assert.areEqual("b4", q.next().first().attr('id'));
	}

	@Test 
	public function next_elementsOnly()
	{
		var children = "#nonElements".find().children(false);
		var comment = children.eq(1);

		Assert.areEqual("Comment", comment.val());
		Assert.areEqual("After", comment.next(false).val());
		Assert.areEqual(0, comment.next().length);
	}

	@Test 
	public function prev()
	{
		for (li in ".pickme".find())
		{
			Assert.areEqual("1", li.toQuery().prev().text());
		}
	}

	@Test 
	public function prev_onNull()
	{
		Assert.areEqual(0, nullQuery.prev().length);
	}

	@Test 
	public function prev_onEmpty()
	{
		Assert.areEqual(0, emptyQuery.prev().length);
	}

	@Test 
	public function prev_onFirst()
	{
		var q = new Query();
		q.addCollection('#a1'.find()); // no prev()
		q.addCollection('#b1'.find()); // no prev()
		q.addCollection('#b2'.find()); // prev() = '#b1'
		Assert.areEqual(1, q.prev().length);
		Assert.areEqual("b1", q.prev().first().attr('id'));
	}

	@Test 
	public function prev_elementsOnly()
	{
		var children = "#nonElements".find().children(false);
		var comment = children.eq(1);

		Assert.areEqual("Comment", comment.val());
		Assert.areEqual("Before", comment.prev(false).val());
		Assert.areEqual(0, comment.prev().length);
	}

	@Test 
	public function find()
	{
		var q = "ul".find();
		Assert.areEqual(8, q.find('li').length);
		Assert.areEqual(2, q.find('.pickme').length);
		Assert.areEqual(1, q.find('#a1').length);
	}

	@Test 
	public function find_onNull()
	{
		Assert.areEqual(0, nullQuery.find('li').length);
	}

	@Test 
	public function find_onEmpty()
	{
		Assert.areEqual(0, emptyQuery.find('li').length);
	}

	@Test 
	public function find_nullInput()
	{
		var q = "ul".find();
		Assert.areEqual(0, q.find(null).length);
	}

	@Test 
	public function find_blankInput()
	{
		var q = "ul".find();
		Assert.areEqual(0, q.find('').length);
	}

	@Test 
	public function find_onNothingFound()
	{
		var q = "ul".find();
		Assert.areEqual(0, q.find('video').length);
	}

}
