package  {
	
	import flash.display.MovieClip;
    import flash.utils.*;
    import com.doublefx.as3.thread.Thread;
    import com.doublefx.as3.thread.api.IThread;
    import com.doublefx.as3.thread.event.ThreadFaultEvent;
    import com.doublefx.as3.thread.event.ThreadProgressEvent;
    import com.doublefx.as3.thread.event.ThreadResultEvent;
    import com.doublefx.as3.thread.event.ThreadStateEvent;

    import BackWorker;
	
	public class Main extends MovieClip {

        private var _thread:IThread;

        public function Main():void {
            _thread = new Thread(BackWorker, "BackWorker");

            _thread.addEventListener(ThreadStateEvent.THREAD_STATE, onThreadState);
            _thread.addEventListener(ThreadProgressEvent.PROGRESS, thread_progressHandler);
            _thread.addEventListener(ThreadResultEvent.RESULT, thread_resultHandler);
            _thread.addEventListener(ThreadFaultEvent.FAULT, thread_faultHandler);

            _thread.start([10,5]);
            trace('-> _thread', describeType(_thread))
			trace('-> Main', _thread.id, _thread.name, _thread.state, _thread.isStarting, _thread.isRunning, _thread.isResuming, _thread.isPausing, _thread.isTerminating)
        }

        private function onThreadState(event:ThreadStateEvent):void {
            trace("Thread State: " + _thread.state);
        }

        private function thread_resultHandler(event:ThreadResultEvent):void {
             trace("Thread State: " + event.result)
            _thread.terminate();
        }

        private function thread_faultHandler(event:ThreadFaultEvent):void {
             trace("Thread State: " +event.fault.message);
            _thread.terminate();
        }

        private function thread_progressHandler(event:ThreadProgressEvent):void {
        }
		
	}
	
}
