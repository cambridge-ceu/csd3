---
sort: 33
---

# ollama

Web: <https://ollama.com/>.

As of 26/2/2025, the current version is 0.5.12.

## Installation

```bash
curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o ollama-linux-amd64.tgz
tar tvfz ollama-linux-amd64.tgz
ollama --help
ollama list
ollama serve &
ollama pull vicuna
ollama run vicuna
```

We see that it is listening at 127.0.0.1:11434 and that the particular module is 3.8GB.

## Chat

From the port given above, our benchmark query is 

```bash
curl http://localhost:11434/api/generate -d '{
  "model": "vicuna",
  "prompt":"Why is the sky blue?"
}'
```

for

```
{"model":"vicuna","created_at":"2025-02-26T15:52:08.033372608Z","response":"The","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:52:19.013203585Z","response":" sky","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:52:30.169018453Z","response":" appears","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:52:38.610246706Z","response":" blue","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:52:51.112631597Z","response":" because","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:53:04.658534982Z","response":" the","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:53:16.545709472Z","response":" Earth","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:53:25.847381482Z","response":"'","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:53:38.26035216Z","response":"s","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:53:50.284336659Z","response":" atmosphere","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:54:01.882921844Z","response":" sc","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:54:13.02017634Z","response":"at","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:54:52.380050323Z","response":"ters","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:55:31.189141976Z","response":" sun","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:56:10.51627649Z","response":"light","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:56:54.358850128Z","response":" in","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:57:37.112980093Z","response":" all","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:58:18.925277666Z","response":" directions","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:59:00.970326803Z","response":" and","done":false}
{"model":"vicuna","created_at":"2025-02-26T15:59:32.906412411Z","response":" blue","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:00:13.823243117Z","response":" light","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:00:51.289339579Z","response":" is","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:01:23.171158404Z","response":" scattered","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:01:57.156218709Z","response":" more","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:02:34.033815548Z","response":" than","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:03:10.703723612Z","response":" other","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:03:47.831095477Z","response":" colors","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:04:23.606689219Z","response":" because","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:04:58.280022861Z","response":" it","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:05:31.74819872Z","response":" travel","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:06:10.808630811Z","response":"s","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:06:50.031448392Z","response":" as","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:07:34.415700349Z","response":" shorter","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:08:11.074102396Z","response":",","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:08:48.048098059Z","response":" smaller","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:09:24.265911278Z","response":" waves","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:10:02.628471441Z","response":".","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:10:44.617544189Z","response":" This","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:11:20.059551286Z","response":" is","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:11:57.277295769Z","response":" why","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:12:31.618643207Z","response":" the","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:13:03.279528158Z","response":" sky","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:13:36.181278012Z","response":" appears","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:14:12.171329827Z","response":" blue","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:14:51.749555584Z","response":" during","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:15:32.594256988Z","response":" the","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:16:11.214666904Z","response":" day","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:16:45.836110502Z","response":"time","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:17:17.724983503Z","response":".","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:17:50.696229461Z","response":" At","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:18:23.257469228Z","response":" night","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:18:57.557381563Z","response":",","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:19:30.689885735Z","response":" when","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:20:06.602847917Z","response":" the","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:20:40.877262517Z","response":" Sun","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:21:19.590447669Z","response":" is","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:21:53.013907482Z","response":" not","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:22:27.903756015Z","response":" visible","done":false}
{"model":"vicuna","created_at":"2025-02-26T16:23:00.580469912Z","response":",","done":false}
...
```

Equialently from the CLI,

```
>>> why the sky is blue
```

> The sky appears blue because of a phenomenon called Rayleigh scattering. When sunlight enters Earth's atmosphere
> encounters tiny gas molecules such as nitrogen and oxygen. These molecules scatter the light ...
