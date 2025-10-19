# Jac Fundamentals: Introduction to Object-Spatial Programming

## Table of Contents
1. [What is Jac?](#what-is-jac)
2. [Fundamental Building Blocks](#fundamental-building-blocks)
3. [The Object-Spatial Programming (OSP) Paradigm](#the-object-spatial-programming-osp-paradigm)
4. [Scale-Agnostic Architecture](#scale-agnostic-architecture)
5. [Python-Like Syntax with Stricter Typing](#python-like-syntax-with-stricter-typing)
6. [Conceptual Example: Friend Network](#conceptual-example-friend-network)
7. [Why It Matters Strategically](#why-it-matters-strategically)
8. [Mini-Project: Personal Connection Map](#mini-project-personal-connection-map)

---

## What is Jac?

**Jac isn't another Python look-alike.**

Jac exists because most real-world data is inherently connected: people to people, files to folders, devices to networks, etc. Traditional programming forces you to simulate these relationships manually using lists, dictionaries, or ORM models. Jac turns these relationships into first-class citizens through **nodes** and **edges**, and lets computation travel along them through **walkers**.

### The Core Problem Jac Solves

This difference becomes critical in systems like:

- **Social networks** - Natural person-to-person relationships
- **Recommendation engines** - Item-to-item and user-to-item connections
- **Family trees** - Hierarchical and lateral relationships
- **Supply chains** - Complex multi-tier dependencies
- **Knowledge graphs** - Entity relationships and semantic connections
- **AI agent networks** - Autonomous agent interactions

### The OSP Paradigm Shift

**Jac's OSP model means you don't bring data to code; you move code to data.**

This fundamental shift enables computation to flow naturally through connected data structures, making complex relationship-based problems much more intuitive to solve.

## Fundamental Building Blocks

Jac's power comes from three core concepts that work together to create a graph-oriented programming paradigm:

### 1. Nodes
**Think of nodes as enhanced Python classes or objects.**

- Hold state (data fields) and live inside a graph
- Defined with the `node` keyword and `has` declarations
- Each node has a unique identity and location in the graph

**Example:**
```jac
node User {
    has username: str;
    has email: str;
    has created_at: datetime;
}
```

### 2. Edges
**Edges represent typed relationships between nodes.**

- Can hold their own attributes and metadata
- Provide first-class relationship management
- Enable traversal and navigation through the graph

**Example:**
```jac
edge FriendsWith {
    has since: str;
    has closeness: int;  # 1-10 scale
}
```

**Connecting nodes:**
```jac
alice +>:FriendsWith(since="2024-05-01", closeness=8):+> bob;
```

This syntax literally means: *"Create a FriendsWith relationship between Alice and Bob, with metadata 'since 2024-05-01' and closeness level 8."*

### 3. Walkers
**Walkers are mobile programs that move through the graph.**

- Execute abilities (functions) when they "land" on nodes
- Think of them as "active agents" rather than passive data queries
- Enable computation to flow naturally through connected data

**Example:**
```jac
walker GreetFriends {
    can greet with Person entry {
        print(f"Hi, {here.name}!");
        visit [->:FriendsWith:->];
    }
}
```

The `visit` statement makes the walker travel across relationships (FriendsWith edges). This is how computation moves to data rather than data moving to computation.

## The Object-Spatial Programming (OSP) Paradigm

OSP fuses Object-Oriented Programming (OOP) and Graph-Oriented Thinking into a unified paradigm that treats relationships as first-class citizens.

### OOP vs OSP Comparison

| Concept             | OOP Analogy         | OSP Enhancement               |
| ------------------- | ------------------- | ----------------------------- |
| Object              | Node                | Node with location in a graph |
| Pointer / Reference | Attribute reference | Edge (typed, first-class)     |
| Function            | Method              | Walker (mobile function)      |

### Key Benefits

- **Distributed Computation**: Your walker can "visit" millions of related objects even across servers — without manual routing logic
- **Natural Data Flow**: Computation follows the natural structure of your data relationships
- **Scalable Architecture**: Built-in support for distributed systems and multi-user environments

## Scale-Agnostic Architecture

Jac applications are designed to scale seamlessly from local development to enterprise deployment without code changes.

### Built-in Capabilities

Jac applications:
- **Run locally or in the cloud** with no code change
- **Automatically persist data** (anything attached to root)
- **Provide multi-user isolation** by default - each user gets their own graph (root context)

### What You Don't Need to Manage

Jac abstracts away the complexity of:
- **Databases** - Automatic persistence and querying
- **Sessions** - Built-in user isolation and state management  
- **Distribution Layers** - Seamless scaling across servers

All of this is handled transparently under the OSP model, allowing you to focus on your application logic rather than infrastructure concerns.

## Python-Like Syntax with Stricter Typing

Jac looks familiar to Python programming but with key differences that enforce better code quality and graph-oriented thinking:

### Key Differences from Python

1. **Mandatory type annotations** - `has name: str;`
2. **Semicolons required** - `;` terminates statements
3. **Functions must declare return types** - `def func() -> int:`
4. **Strong emphasis on graph traversal** - Built-in spatial context awareness

### Syntax Examples

**Node Definition:**
```jac
node Person {
    has name: str;
    has age: int;
    has interests: list[str] = [];
}
```

**Function Definition:**
```jac
def calculate_age(birth_year: int) -> int {
    return 2024 - birth_year;
}
```

**Walker Definition:**
```jac
walker ProcessData {
    has results: list[str] = [];
    
    can process with DataNode entry {
        # Process the data here
        self.results.append(here.value);
    }
}
```

## Conceptual Example: Friend Network

Let's build a complete example that demonstrates Jac's core concepts in action. We'll create a friend network system that shows how nodes, edges, and walkers work together.

### Step 1: Define Data Types
*You model the world*

First, we need to define the structure of our data. We'll create a Person node to hold information about each individual and a FriendsWith edge to represent their relationships.

```jac
node Person {
    has name: str;
    has age: int;
    has interests: list[str] = [];
}

edge FriendsWith {
    has since: str;
    has closeness: int;  # 1-10 scale
}
```

### Step 2: Populate Data
*You instantiate the world*

Now that we have our blueprints, let's create a few people and connect them as friends. Notice how we can add data directly to the FriendsWith edge when we create it.

```jac
alice = root ++> Person(
    name = "Alice",
    age = 25,
    interests = ["coding", "music", "hiking"]
);

bob = root ++> Person(
    name = "Bob", 
    age = 27,
    interests = ["sports", "music", "cooking"]
);

charlie = root ++> Person(
    name = "Charlie",
    age = 24,
    interests = ["coding", "music", "gaming"]
);
```

### Step 3: Connect Relationships
*You link the world*

Create the friendships with metadata:

```jac
alice +>:FriendsWith(since="2020-01-15", closeness=8):+> bob;
alice +>:FriendsWith(since="2021-06-10", closeness=9):+> charlie;
bob +>:FriendsWith(since="2020-12-03", closeness=7):+> charlie;
```

### Step 4: Move Computation
*You interrogate the world*

Next, we need a way to analyze our network. Let's create a walker that can travel between friends and find out what interests they have in common.

```jac
walker FindCommonInterests {
    // The walker needs to know who we're comparing against
    has target_person: Person;
    
    // It will store results of the search here
    has common_interests: list[str] = [];
    
    // This ability runs automatically whenever the walker lands on a person node
    can find_common with Person entry {
        // We don't want to compare person with themselves
        if here == self.target_person {
            return;  // skip self
        }
        
        // Find any interests this person shares with our target_person
        shared = [];
        for interest in here.interests {
            if interest in self.target_person.interests {
                shared.append(interest);
            }
        }
        
        // If we found any, print them and add them to our list
        if shared {
            self.common_interests.extend(shared);
            print(f"{here.name} and {self.target_person.name} both like: {','.join(shared)}");
        }
    }
}
```

This walker acts like an intelligent agent that traverses your network and computes insights where the data lives.

## Why It Matters Strategically

Learning Jac means learning to think spatially about programming problems. This mindset shift has profound implications for modern software development.

### The Spatial Programming Mindset

When you learn Jac, you're learning to think spatially:

- **Relationships are data structures** - Not just pointers or foreign keys
- **Traversal is computation flow** - Movement through data becomes the primary operation
- **Each node/edge is self-contained and stateful** - Data carries its own context
- **Walkers are like AI agents** - They perform reasoning tasks autonomously

### Future-Ready Skills

This is the mindset behind next-generation AI systems:

- **Networks of agents** - Autonomous systems that communicate and collaborate
- **Knowledge graphs** - Structured representations of information and relationships
- **Autonomous data flows** - Self-organizing systems that adapt and evolve

By mastering Jac, you're preparing for a future where software systems are increasingly distributed, intelligent, and relationship-driven.

## Mini-Project: Personal Connection Map

### Goal
Build a small Jac application that helps you visualize or log your personal/professional connections, such as classmates, colleagues, or clients, along with how you met and what you share in common.

### Requirements

#### 1. Data Structure
Create:

**Person Node:**
```jac
node Person {
    has name: str;
    has occupation: str;
    has city: str;
    has interests: list[str] = [];
}
```

**Knows Edge:**
```jac
edge Knows {
    has since: str;        // When you met
    has met_at: str;       // Where you met
    has closeness: int;    // 1-10 scale
}
```

#### 2. Walker Implementation

**FindNearbyFriends Walker:**
```jac
walker FindNearbyFriends {
    has current_city: str;
    
    can find_nearby with Person entry {
        if here.city == self.current_city {
            print(f"Found nearby friend: {here.name} ({here.occupation})");
        }
        visit [->:Knows:->];
    }
}
```

**SharedInterests Walker:**
```jac
walker SharedInterests {
    has target_interests: list[str];
    has matches: list[Person] = [];
    
    can find_shared with Person entry {
        shared = [];
        for interest in here.interests {
            if interest in self.target_interests {
                shared.append(interest);
            }
        }
        
        if shared {
            self.matches.append(here);
            print(f"{here.name} shares interests: {', '.join(shared)}");
        }
        visit [->:Knows:->];
    }
}
```

#### 3. Demonstration
Demonstrate the program using at least three people (e.g., yourself and two friends/colleagues).

**Example Usage:**
```jac
// Create people
me = root ++> Person(
    name = "Alex",
    occupation = "Software Developer", 
    city = "San Francisco",
    interests = ["coding", "hiking", "photography"]
);

colleague = root ++> Person(
    name = "Sarah",
    occupation = "Designer",
    city = "San Francisco", 
    interests = ["design", "hiking", "art"]
);

friend = root ++> Person(
    name = "Mike",
    occupation = "Teacher",
    city = "Los Angeles",
    interests = ["education", "music", "photography"]
);

// Create relationships
me +>:Knows(since="2023-01-15", met_at="Office", closeness=8):+> colleague;
me +>:Knows(since="2020-06-10", met_at="College", closeness=9):+> friend;

// Run walkers
walker FindNearbyFriends {
    has current_city: str = "San Francisco";
    can find_nearby with Person entry {
        if here.city == self.current_city {
            print(f"Found nearby friend: {here.name} ({here.occupation})");
        }
        visit [->:Knows:->];
    }
}

walker SharedInterests {
    has target_interests: list[str] = ["hiking", "photography"];
    has matches: list[Person] = [];
    
    can find_shared with Person entry {
        shared = [];
        for interest in here.interests {
            if interest in self.target_interests {
                shared.append(interest);
            }
        }
        
        if shared {
            self.matches.append(here);
            print(f"{here.name} shares interests: {', '.join(shared)}");
        }
        visit [->:Knows:->];
    }
}
```

### Stretch Goal (Optional)

Modify the program so that when you run it with `jac serve`, the network persists — so new connections are remembered automatically each time you run it.

**Hint:** Use `root` context to ensure data persistence across sessions.

---

## Summary

Jac represents a paradigm shift from traditional programming to spatial, relationship-driven development. By treating connections as first-class citizens and enabling computation to flow through data structures, Jac makes complex relationship-based problems more intuitive and scalable.

### Key Takeaways

- **Nodes, Edges, and Walkers** form the foundation of Jac programming
- **OSP paradigm** enables natural data flow and distributed computation  
- **Scale-agnostic architecture** handles persistence and distribution automatically
- **Spatial thinking** prepares you for next-generation AI and distributed systems

Ready to start building? Begin with the Mini-Project above, then explore more advanced Jac concepts as you grow comfortable with the spatial programming mindset.

---

*This introduction provides the foundation for understanding Jac's unique approach to programming. Continue exploring the Jac Fundamentals series to dive deeper into specific concepts and advanced techniques.*