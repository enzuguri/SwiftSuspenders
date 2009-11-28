package org.swiftsuspenders 
{

	import org.swiftsuspenders.support.injectees.SingletonSetup;
	import org.swiftsuspenders.support.types.ClassExisitsInParent;
	import org.swiftsuspenders.support.injectees.ParentingInjectee;
	import org.swiftsuspenders.support.injectees.ClassInjectee;
	import org.swiftsuspenders.support.types.Clazz;
	import flexunit.framework.Assert;
	/**
	 * @author alex
	 */
	public class ParentingTests 
	{

		private var parentInjector : Injector;
		private var childInjector : Injector;

		[Before]
		public function setup() : void
		{
			parentInjector = new Injector();
			childInjector = new Injector();
		}
		
		[After]
		public function teardown() : void
		{
		}
		
		[Test]
		public function parentSetterTest():void
		{
			childInjector.parent = parentInjector;
			
			Assert.assertEquals("Child now has parent", childInjector.parent, parentInjector);
		}
		
		[Test]
		public function testInclusionOfParentMapping():void
		{
			parentInjector.mapSingleton(ClassExisitsInParent);
			
			
			var instance : SingletonSetup = parentInjector.instantiate(SingletonSetup);
			
			Assert.assertNotNull("retrieved instance", instance);

			Assert.assertNotNull("retrieved instance", instance.exisit);
			
			childInjector.parent = parentInjector;
			
			
			var childInstance:ParentingInjectee = childInjector.instantiate(ParentingInjectee);
			
			Assert.assertNotNull("assert that we created the child", childInstance);

			Assert.assertNotNull("assert that we have a prop", childInstance.prop);
			
			Assert.assertEquals("assert that the child instance is the same as the parent", instance.exisit, childInstance.prop);
		}
	}
}
